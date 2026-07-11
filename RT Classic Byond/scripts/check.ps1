[CmdletBinding()]
param(
    [switch]$Strict
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$dmePath = Join-Path $repoRoot 'Roleplay Tenkaichi.dme'
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$directoryCache = @{}

function Add-CheckError([string]$Message) {
    $errors.Add($Message)
}

function Get-CanonicalRelativePath([string]$RelativePath) {
    $current = $repoRoot
    $actualSegments = [System.Collections.Generic.List[string]]::new()

    foreach ($segment in (($RelativePath -replace '/', '\').Split('\'))) {
        if (-not $segment -or $segment -eq '.') { continue }

        $cacheKey = $current.ToLowerInvariant()
        if (-not $directoryCache.ContainsKey($cacheKey)) {
            $directoryCache[$cacheKey] = @(Get-ChildItem -LiteralPath $current -Force)
        }
        $match = $directoryCache[$cacheKey] |
            Where-Object { $_.Name -ieq $segment } |
            Select-Object -First 1
        if (-not $match) { return $null }

        $actualSegments.Add($match.Name)
        $current = $match.FullName
    }

    return ($actualSegments -join '\')
}

$requiredPaths = @(
    'Code',
    'Code\Items',
    'Code\Mob',
    'Code\Skills',
    'Code\Modules',
    'Code\_Atom',
    'Code\_Datums',
    'Code\_HELPERS',
    'assets',
    'RT.dmf'
)

foreach ($relativePath in $requiredPaths) {
    if (-not (Test-Path -LiteralPath (Join-Path $repoRoot $relativePath))) {
        Add-CheckError "Required project path is missing: $relativePath"
    }
}

if (-not (Test-Path -LiteralPath $dmePath -PathType Leaf)) {
    Write-Error 'Roleplay Tenkaichi.dme was not found at the repository root.'
}

$dmeLines = Get-Content -LiteralPath $dmePath
$beginIncludeCount = @($dmeLines | Where-Object { $_ -eq '// BEGIN_INCLUDE' }).Count
$endIncludeCount = @($dmeLines | Where-Object { $_ -eq '// END_INCLUDE' }).Count
if ($beginIncludeCount -ne 1 -or $endIncludeCount -ne 1) {
    Add-CheckError 'The DME must contain exactly one BEGIN_INCLUDE and one END_INCLUDE marker.'
}

$includePattern = '^\s*#include\s+"([^"]+)"'
$includes = foreach ($line in $dmeLines) {
    if ($line -match $includePattern) {
        $matches[1]
    }
}

foreach ($include in $includes) {
    $resolved = Join-Path $repoRoot ($include -replace '\\', [IO.Path]::DirectorySeparatorChar)
    if (-not (Test-Path -LiteralPath $resolved -PathType Leaf)) {
        Add-CheckError "Missing include: $include"
        continue
    }

    $normalizedInclude = $include -replace '/', '\'
    $canonicalPath = Get-CanonicalRelativePath $normalizedInclude
    if ($canonicalPath -cne $normalizedInclude) {
        $message = "Include path casing differs from disk: $include (disk: $canonicalPath)"
        if ($Strict) { Add-CheckError $message } else { $warnings.Add($message) }
    }
}

$duplicates = $includes | Group-Object | Where-Object Count -gt 1
foreach ($duplicate in $duplicates) {
    Add-CheckError "Duplicate include ($($duplicate.Count)x): $($duplicate.Name)"
}

$sourceFiles = Get-ChildItem -LiteralPath (Join-Path $repoRoot 'Code') -Recurse -File -Filter '*.dm'
$normalizedIncludes = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
foreach ($include in $includes) {
    [void]$normalizedIncludes.Add(($include -replace '/', '\'))
}

$unreferencedSources = [System.Collections.Generic.List[string]]::new()
foreach ($source in $sourceFiles) {
    $relative = $source.FullName.Substring($repoRoot.Length + 1)
    if (-not $normalizedIncludes.Contains($relative)) {
        $unreferencedSources.Add($relative)
    }
}

if ($Strict) {
    foreach ($source in $unreferencedSources) {
        Add-CheckError "Source is not included by the DME: $source"
    }
} elseif ($unreferencedSources.Count -gt 0) {
    $warnings.Add("$($unreferencedSources.Count) Code/*.dm files are not included by the DME. Run with -Strict to list them as errors.")
}

$editableExtensions = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
@('.dm', '.dme', '.dmf', '.ps1', '.md', '.html', '.css', '.js') | ForEach-Object {
    [void]$editableExtensions.Add($_)
}
$editableFiles = @(
    Get-ChildItem -LiteralPath (Join-Path $repoRoot 'Code'), (Join-Path $repoRoot 'assets'), (Join-Path $repoRoot 'scripts') -Recurse -File |
        Where-Object { $editableExtensions.Contains($_.Extension) }
)
$editableFiles += Get-Item -LiteralPath $dmePath, (Join-Path $repoRoot 'RT.dmf'), (Join-Path $repoRoot 'AGENTS.md')
$conflictPattern = '^(<<<<<<< |=======|>>>>>>> )'
foreach ($match in ($editableFiles | Select-String -Pattern $conflictPattern)) {
    $relative = $match.Path.Substring($repoRoot.Length + 1)
    Add-CheckError "Unresolved Git conflict marker: ${relative}:$($match.LineNumber)"
}

$gitCommand = Get-Command git -ErrorAction SilentlyContinue
if ($gitCommand) {
    $changedPaths = @(& git -c core.autocrlf=false -C $repoRoot diff --name-only --no-renames HEAD --)
    if ($LASTEXITCODE -ne 0) { Add-CheckError 'Unable to inspect tracked Git changes.' }
    $changedPaths += @(& git -C $repoRoot ls-files --others --exclude-standard)
    if ($LASTEXITCODE -ne 0) { Add-CheckError 'Unable to inspect untracked Git changes.' }

    $protectedExtensions = @(
        '.bdb', '.dmb', '.dmi', '.dmm', '.gif', '.int', '.jpeg', '.jpg', '.log',
        '.mid', '.mp3', '.ogg', '.png', '.rsc', '.ttf', '.wav', '.zip'
    )
    foreach ($path in ($changedPaths | Sort-Object -Unique)) {
        $normalizedPath = $path -replace '\\', '/'
        $extension = [IO.Path]::GetExtension($normalizedPath).ToLowerInvariant()
        $isProtected = $normalizedPath -match '^(Data|Fonts|Icons)/' -or
            $normalizedPath -eq 'RT.dmf' -or
            $protectedExtensions -contains $extension -or
            $normalizedPath -match '\.dyn\.rsc$'
        if ($isProtected) {
            Add-CheckError "Protected runtime, resource, or generated path has Git changes: $path"
        }
    }
} else {
    $warnings.Add('Git is unavailable; protected-path change checks were skipped.')
}

foreach ($warning in $warnings) {
    Write-Warning $warning
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ -ErrorAction Continue }
    exit 1
}

Write-Host "Repository check passed: $($includes.Count) includes resolved; $($sourceFiles.Count) Code/*.dm files inspected; $($editableFiles.Count) editable text files checked."
