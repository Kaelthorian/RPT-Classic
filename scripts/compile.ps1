[CmdletBinding()]
param(
    [string]$CompilerPath,
    [switch]$KeepBuildDirectory,
    [switch]$SkipStructuralCheck
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$projectName = 'Roleplay Tenkaichi.dme'
$projectPath = Join-Path $repoRoot $projectName

if (-not $SkipStructuralCheck) {
    & (Join-Path $PSScriptRoot 'check.ps1')
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

function Resolve-DreamMakerCompiler([string]$RequestedPath) {
    $candidates = [System.Collections.Generic.List[string]]::new()
    if ($RequestedPath) { $candidates.Add($RequestedPath) }
    if ($env:BYOND_DM_PATH) { $candidates.Add($env:BYOND_DM_PATH) }

    foreach ($localName in @('.local-tools\BYOND\bin\dm.exe', '.local-tools\BYOND\bin\DreamMaker.exe')) {
        $candidates.Add((Join-Path $repoRoot $localName))
    }

    foreach ($commandName in @('dm.exe', 'DreamMaker.exe')) {
        $command = Get-Command $commandName -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($command) { $candidates.Add($command.Source) }
    }

    foreach ($base in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:LOCALAPPDATA, $env:USERPROFILE)) {
        if (-not $base) { continue }
        foreach ($relative in @('BYOND\bin\dm.exe', 'BYOND\bin\DreamMaker.exe')) {
            $candidates.Add((Join-Path $base $relative))
        }
    }

    foreach ($candidate in ($candidates | Select-Object -Unique)) {
        if (-not $candidate) { continue }
        try { $full = [IO.Path]::GetFullPath($candidate) } catch { continue }
        if (Test-Path -LiteralPath $full -PathType Leaf) { return $full }
    }
    return $null
}

$compiler = Resolve-DreamMakerCompiler $CompilerPath
if (-not $compiler) {
    Write-Error 'Dream Maker compiler not found. Pass -CompilerPath or set BYOND_DM_PATH.' -ErrorAction Continue
    exit 2
}

Write-Host 'Selected Dream Maker compiler:'
Write-Host "  $compiler"

$buildRoot = Join-Path ([IO.Path]::GetTempPath()) ("RPT-Classic-verify-" + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $buildRoot | Out-Null

try {
    $robocopy = Get-Command robocopy.exe -ErrorAction SilentlyContinue
    if (-not $robocopy) {
        Write-Error 'robocopy.exe is required for safe staged compilation on Windows.' -ErrorAction Continue
        exit 3
    }

    & robocopy.exe $repoRoot $buildRoot /E /NFL /NDL /NJH /NJS /NP `
        /XD '.git' '.codex' '.local-tools' 'Data' `
        /XF '*.dmb' '*.rsc' '*.dyn.rsc' '*.int' '*.log'
    $copyExitCode = $LASTEXITCODE
    if ($copyExitCode -ge 8) {
        Write-Error "Staging copy failed with robocopy exit code $copyExitCode." -ErrorAction Continue
        exit 4
    }

    $stagedProject = Join-Path $buildRoot $projectName
    if (-not (Test-Path -LiteralPath $stagedProject -PathType Leaf)) {
        Write-Error 'The staged DME was not created.' -ErrorAction Continue
        exit 5
    }

    Write-Host "Compiling staged project: $stagedProject"
    Push-Location $buildRoot
    try {
        & $compiler -full_paths $stagedProject
        $compilerExitCode = $LASTEXITCODE
    } finally {
        Pop-Location
    }

    if ($compilerExitCode -ne 0) {
        Write-Error "Dream Maker compilation failed with exit code $compilerExitCode." -ErrorAction Continue
        exit $compilerExitCode
    }

    Write-Host 'Dream Maker compilation passed.'
} finally {
    if ($KeepBuildDirectory) {
        Write-Host "Staging directory retained: $buildRoot"
    } elseif (Test-Path -LiteralPath $buildRoot) {
        Remove-Item -LiteralPath $buildRoot -Recurse -Force
    }
}
