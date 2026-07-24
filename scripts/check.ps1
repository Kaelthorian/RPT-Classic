[CmdletBinding()]
param(
    [switch]$Strict,
    [switch]$StrictSecrets
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$dmePath = Join-Path $repoRoot 'Roleplay Tenkaichi.dme'
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()

function Add-CheckError([string]$Message) {
    $errors.Add($Message)
}

function Add-CheckWarning([string]$Message) {
    $warnings.Add($Message)
}

$requiredPaths = @(
    'Roleplay Tenkaichi.dme',
    'RT.dmf',
    'Code',
    'Code\Items',
    'Code\Map',
    'Code\Mob',
    'Code\Modules',
    'Code\Skills',
    'Code\_Atom',
    'Code\_Datums',
    'Code\_HELPERS',
    'AGENTS.md'
)

foreach ($relativePath in $requiredPaths) {
    $fullPath = Join-Path $repoRoot $relativePath
    if (-not (Test-Path -LiteralPath $fullPath)) {
        Add-CheckError "Required project path is missing: $relativePath"
    }
}

if (-not (Test-Path -LiteralPath $dmePath -PathType Leaf)) {
    Add-CheckError 'Roleplay Tenkaichi.dme was not found at the repository root.'
} else {
    $dmeLines = Get-Content -LiteralPath $dmePath
    if (@($dmeLines | Where-Object { $_ -eq '// BEGIN_INCLUDE' }).Count -ne 1) {
        Add-CheckError 'The DME must contain exactly one // BEGIN_INCLUDE marker.'
    }
    if (@($dmeLines | Where-Object { $_ -eq '// END_INCLUDE' }).Count -ne 1) {
        Add-CheckError 'The DME must contain exactly one // END_INCLUDE marker.'
    }

    $includePattern = '^\s*#include\s+"([^"]+)"'
    $includes = foreach ($line in $dmeLines) {
        if ($line -match $includePattern) { $matches[1] }
    }

    foreach ($include in $includes) {
        $normalized = $include -replace '\\', [IO.Path]::DirectorySeparatorChar
        $resolved = Join-Path $repoRoot $normalized
        if (-not (Test-Path -LiteralPath $resolved -PathType Leaf)) {
            Add-CheckError "Missing include: $include"
        }
    }

    foreach ($duplicate in ($includes | Group-Object | Where-Object Count -gt 1)) {
        Add-CheckError "Duplicate include ($($duplicate.Count)x): $($duplicate.Name)"
    }

    $sourceRoot = Join-Path $repoRoot 'Code'
    if (Test-Path -LiteralPath $sourceRoot) {
        $sourceFiles = @(Get-ChildItem -LiteralPath $sourceRoot -Recurse -File -Filter '*.dm')
        $includeSet = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
        foreach ($include in $includes) {
            [void]$includeSet.Add(($include -replace '/', '\'))
        }

        $orphans = foreach ($source in $sourceFiles) {
            $relative = $source.FullName.Substring($repoRoot.Length + 1) -replace '/', '\'
            if (-not $includeSet.Contains($relative)) { $relative }
        }

        if ($orphans.Count -gt 0) {
            if ($Strict) {
                foreach ($orphan in $orphans) { Add-CheckError "Code source is not included by the DME: $orphan" }
            } else {
                Add-CheckWarning "$($orphans.Count) Code/*.dm files are not included by the DME. Run with -Strict to list them as errors."
            }
        }
    }
}

$editableRoots = @('Code', 'assets', 'docs', 'scripts')
$editableFiles = [System.Collections.Generic.List[System.IO.FileInfo]]::new()
foreach ($relativeRoot in $editableRoots) {
    $fullRoot = Join-Path $repoRoot $relativeRoot
    if (Test-Path -LiteralPath $fullRoot) {
        foreach ($file in (Get-ChildItem -LiteralPath $fullRoot -Recurse -File)) {
            if ($file.Extension -in @('.dm', '.md', '.ps1', '.html', '.css', '.js')) {
                $editableFiles.Add($file)
            }
        }
    }
}
foreach ($rootFile in @('AGENTS.md', 'README.md', 'ARCHITECTURE.md', 'DEVELOPMENT.md', 'SECURITY.md', 'KNOWN_RISKS.md', 'CODEX_TASK_PROTOCOL.md', 'Roleplay Tenkaichi.dme')) {
    $fullPath = Join-Path $repoRoot $rootFile
    if (Test-Path -LiteralPath $fullPath -PathType Leaf) {
        $editableFiles.Add((Get-Item -LiteralPath $fullPath))
    }
}

$conflictPattern = '^(<<<<<<< |=======|>>>>>>> )'
foreach ($match in ($editableFiles | Select-String -Pattern $conflictPattern)) {
    $relative = $match.Path.Substring($repoRoot.Length + 1)
    Add-CheckError "Unresolved Git conflict marker: ${relative}:$($match.LineNumber)"
}

$secretPatterns = @(
    'discord(?:app)?\.com/api/webhooks/',
    '(?i)hub_password\s*=',
    '(?i)(password|token|secret|api[_-]?key)\s*=\s*"[^"\r\n]+"'
)
foreach ($pattern in $secretPatterns) {
    foreach ($match in ($editableFiles | Select-String -Pattern $pattern)) {
        $relative = $match.Path.Substring($repoRoot.Length + 1)
        $message = "Potential committed secret pattern: ${relative}:$($match.LineNumber) (value intentionally not displayed)"
        if ($StrictSecrets) { Add-CheckError $message } else { Add-CheckWarning $message }
    }
}

$git = Get-Command git -ErrorAction SilentlyContinue
if ($git) {
    $changedPaths = @(& git -C $repoRoot diff --name-only --no-renames HEAD --)
    if ($LASTEXITCODE -ne 0) { Add-CheckError 'Unable to inspect tracked Git changes.' }
    $changedPaths += @(& git -C $repoRoot ls-files --others --exclude-standard)
    if ($LASTEXITCODE -ne 0) { Add-CheckError 'Unable to inspect untracked Git changes.' }

    $protectedExtensions = @('.bdb', '.dmb', '.dmi', '.dmm', '.gif', '.int', '.jpeg', '.jpg', '.log', '.mid', '.mp3', '.ogg', '.png', '.rsc', '.ttf', '.wav', '.zip')
    foreach ($path in ($changedPaths | Sort-Object -Unique)) {
        $normalizedPath = $path -replace '\\', '/'
        $extension = [IO.Path]::GetExtension($normalizedPath).ToLowerInvariant()
        $isProtected = $normalizedPath -match '^(Data|Fonts|Icons)/' -or
            $normalizedPath -eq 'RT.dmf' -or
            $protectedExtensions -contains $extension -or
            $normalizedPath -match '\.dyn\.rsc$'
        if ($isProtected) {
            Add-CheckError "Protected runtime, resource, map, UI, or generated path has Git changes: $path"
        }
    }
} else {
    Add-CheckWarning 'Git is unavailable; working-tree protected-path checks were skipped.'
}

foreach ($warning in $warnings) { Write-Warning $warning }

if ($errors.Count -gt 0) {
    foreach ($errorMessage in $errors) { Write-Error $errorMessage -ErrorAction Continue }
    exit 1
}

Write-Host 'Repository structural check passed.'
