[CmdletBinding()]
param(
    [string]$CompilerPath
)

$ErrorActionPreference = 'Stop'

Write-Host 'Step 1/2: structural repository checks'
& (Join-Path $PSScriptRoot 'check.ps1')
if ($LASTEXITCODE -ne 0) {
    Write-Error "Structural validation failed with exit code $LASTEXITCODE." -ErrorAction Continue
    exit $LASTEXITCODE
}

Write-Host 'Step 2/2: real Dream Maker compilation'
if ($CompilerPath) {
    & (Join-Path $PSScriptRoot 'compile.ps1') -CompilerPath $CompilerPath
} else {
    & (Join-Path $PSScriptRoot 'compile.ps1')
}
$compileExitCode = $LASTEXITCODE
if ($compileExitCode -ne 0) {
    Write-Error "Repository verification failed during Dream Maker compilation (exit $compileExitCode)." -ErrorAction Continue
    exit $compileExitCode
}

Write-Host 'Repository verification succeeded: structural checks and Dream Maker compilation both passed.'
exit 0
