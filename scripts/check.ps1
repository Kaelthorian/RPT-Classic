[CmdletBinding()]
param(
    [switch]$Strict
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$dmePath = Join-Path $repoRoot 'Roleplay Tenkaichi.dme'
$errors = [System.Collections.Generic.List[string]]::new()

if (-not (Test-Path -LiteralPath $dmePath -PathType Leaf)) {
    Write-Error 'Roleplay Tenkaichi.dme was not found at the repository root.'
}

$includePattern = '^\s*#include\s+"([^"]+)"'
$includes = foreach ($line in Get-Content -LiteralPath $dmePath) {
    if ($line -match $includePattern) {
        $matches[1]
    }
}

foreach ($include in $includes) {
    $resolved = Join-Path $repoRoot ($include -replace '\\', [IO.Path]::DirectorySeparatorChar)
    if (-not (Test-Path -LiteralPath $resolved -PathType Leaf)) {
        $errors.Add("Missing include: $include")
    }
}

$duplicates = $includes | Group-Object | Where-Object Count -gt 1
foreach ($duplicate in $duplicates) {
    $errors.Add("Duplicate include ($($duplicate.Count)x): $($duplicate.Name)")
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
        $errors.Add("Source is not included by the DME: $source")
    }
} elseif ($unreferencedSources.Count -gt 0) {
    Write-Warning "$($unreferencedSources.Count) Code/*.dm files are not included by the DME. Run with -Strict to list them as errors."
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ -ErrorAction Continue }
    exit 1
}

Write-Host "Repository check passed: $($includes.Count) includes resolved; $($sourceFiles.Count) Code/*.dm files inspected."
