[CmdletBinding()]
param(
    [string]$CompilerPath
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$projectName = 'Roleplay Tenkaichi.dme'
$projectPath = Join-Path $repoRoot $projectName
$compilerNotFoundExitCode = 3
$stagingFailureExitCode = 4

function Find-DreamMakerCompiler {
    param([string]$ExplicitPath)

    if ($ExplicitPath) {
        try {
            $resolved = [IO.Path]::GetFullPath($ExplicitPath)
        } catch {
            throw "The explicit compiler path is invalid: $ExplicitPath"
        }
        if (-not (Test-Path -LiteralPath $resolved -PathType Leaf)) {
            throw "The explicit compiler path does not exist: $resolved"
        }
        return $resolved
    }

    $candidates = [System.Collections.Generic.List[string]]::new()
    $legacyCandidates = [System.Collections.Generic.List[string]]::new()

    # BYOND's supported command-line compiler is normally dm.exe. Older or custom
    # installations may expose DreamMaker.exe instead.
    $localCompiler = Join-Path $repoRoot '.local-tools\BYOND\bin\dm.exe'
    if (Test-Path -LiteralPath $localCompiler -PathType Leaf) {
        return [IO.Path]::GetFullPath($localCompiler)
    }

    $localLegacyCompiler = Join-Path $repoRoot '.local-tools\BYOND\bin\dreammaker.exe'
    if (Test-Path -LiteralPath $localLegacyCompiler -PathType Leaf) {
        return [IO.Path]::GetFullPath($localLegacyCompiler)
    }

    if ($env:BYOND_DM_PATH) {
        try {
            $environmentCompiler = [IO.Path]::GetFullPath($env:BYOND_DM_PATH)
        } catch {
            $environmentCompiler = $null
        }
        if ($environmentCompiler -and (Test-Path -LiteralPath $environmentCompiler -PathType Leaf)) {
            return $environmentCompiler
        }
    }

    $command = Get-Command 'dm.exe' -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($command) { $candidates.Add($command.Source) }
    $command = Get-Command 'DreamMaker.exe' -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($command) { $legacyCandidates.Add($command.Source) }

    $uninstallRoots = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )
    foreach ($entry in (Get-ItemProperty $uninstallRoots -ErrorAction SilentlyContinue |
        Where-Object { $_.DisplayName -eq 'BYOND' -or $_.Publisher -match 'BYOND|Dantom' })) {
        if ($entry.InstallLocation) {
            $candidates.Add((Join-Path $entry.InstallLocation 'bin\dm.exe'))
            $legacyCandidates.Add((Join-Path $entry.InstallLocation 'bin\DreamMaker.exe'))
        }
    }

    if (${env:ProgramFiles(x86)}) {
        $candidates.Add((Join-Path ${env:ProgramFiles(x86)} 'BYOND\bin\dm.exe'))
        $legacyCandidates.Add((Join-Path ${env:ProgramFiles(x86)} 'BYOND\bin\DreamMaker.exe'))
    }
    if ($env:ProgramFiles) {
        $candidates.Add((Join-Path $env:ProgramFiles 'BYOND\bin\dm.exe'))
        $legacyCandidates.Add((Join-Path $env:ProgramFiles 'BYOND\bin\DreamMaker.exe'))
    }
    if ($env:LOCALAPPDATA) {
        $candidates.Add((Join-Path $env:LOCALAPPDATA 'BYOND\bin\dm.exe'))
        $legacyCandidates.Add((Join-Path $env:LOCALAPPDATA 'BYOND\bin\DreamMaker.exe'))
    }
    if ($env:USERPROFILE) {
        $candidates.Add((Join-Path $env:USERPROFILE 'BYOND\bin\dm.exe'))
        $legacyCandidates.Add((Join-Path $env:USERPROFILE 'BYOND\bin\DreamMaker.exe'))
    }

    foreach ($candidate in (@($candidates) + @($legacyCandidates) | Select-Object -Unique)) {
        if ($candidate -and (Test-Path -LiteralPath $candidate -PathType Leaf)) {
            return [IO.Path]::GetFullPath($candidate)
        }
    }

    return $null
}

if (-not (Test-Path -LiteralPath $projectPath -PathType Leaf)) {
    Write-Error "Dream Maker project not found: $projectPath" -ErrorAction Continue
    exit $stagingFailureExitCode
}

try {
    $compiler = Find-DreamMakerCompiler $CompilerPath
} catch {
    Write-Error "Dream Maker compiler unavailable: $($_.Exception.Message)" -ErrorAction Continue
    exit $compilerNotFoundExitCode
}

if (-not $compiler) {
    Write-Error 'Dream Maker compiler unavailable. Checked the repository-local BYOND tools, BYOND_DM_PATH, PATH, the Windows BYOND uninstall registry entries, Program Files, LocalAppData, and the user BYOND directory. Pass -CompilerPath with the full path to dm.exe if it is installed elsewhere.' -ErrorAction Continue
    exit $compilerNotFoundExitCode
}

Write-Host 'Selected Dream Maker compiler:'
Write-Host "  $compiler"

# Dream Maker writes .dmb/.rsc outputs beside the DME. Compile a working-tree
# mirror so validation cannot overwrite tracked outputs or touch runtime data.
$tempBase = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
$buildRoot = Join-Path $tempBase ('rpt-classic-compile-' + [guid]::NewGuid().ToString('N'))
$buildRoot = [IO.Path]::GetFullPath($buildRoot)
if (-not $buildRoot.StartsWith($tempBase, [StringComparison]::OrdinalIgnoreCase)) {
    Write-Error 'Refusing to stage the build outside the system temporary directory.' -ErrorAction Continue
    exit $stagingFailureExitCode
}

$compileExitCode = $stagingFailureExitCode
try {
    New-Item -ItemType Directory -Path $buildRoot | Out-Null

    # Data is deliberately excluded: saves and runtime databases are not required
    # by the compiler and must never be copied into build staging.
    & robocopy.exe $repoRoot $buildRoot /E /NFL /NDL /NJH /NJS /NP `
        /XD '.git' '.codex' '.local-tools' 'Data' `
        /XF '*.dmb' '*.rsc' '*.dyn.rsc' '*.int' '*.log'
    $copyExitCode = $LASTEXITCODE
    if ($copyExitCode -ge 8) {
        Write-Error "Unable to stage the project for compilation (robocopy exit $copyExitCode)." -ErrorAction Continue
        exit $stagingFailureExitCode
    }

    $stagedProject = Join-Path $buildRoot $projectName
    Write-Host "Compiling staged project: $stagedProject"
    Write-Host "Command: & `"$compiler`" -full_paths `"$stagedProject`""
    Write-Host 'Structural validation is not compilation; success is reported only if Dream Maker exits with code 0.'

    Push-Location $buildRoot
    try {
        # Do not pipe or filter this command: all compiler warnings and output must
        # remain visible, and LASTEXITCODE must come directly from Dream Maker.
        & $compiler '-full_paths' $stagedProject
        $compileExitCode = $LASTEXITCODE
    } finally {
        Pop-Location
    }

    if ($compileExitCode -ne 0) {
        Write-Error "Dream Maker compilation failed with exit code $compileExitCode." -ErrorAction Continue
    } else {
        Write-Host 'Dream Maker compilation succeeded (exit code 0).'
    }
} catch {
    Write-Error "Compilation could not be executed: $($_.Exception.Message)" -ErrorAction Continue
    $compileExitCode = $stagingFailureExitCode
} finally {
    if ((Test-Path -LiteralPath $buildRoot) -and
        $buildRoot.StartsWith($tempBase, [StringComparison]::OrdinalIgnoreCase) -and
        (Split-Path -Leaf $buildRoot) -like 'rpt-classic-compile-*') {
        Remove-Item -LiteralPath $buildRoot -Recurse -Force
    }
}

exit $compileExitCode
