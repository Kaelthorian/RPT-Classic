[CmdletBinding()]
param(
    [string]$CompilerPath,
    [switch]$KeepBuildDirectory,
    [switch]$Strict,
    [switch]$StrictSecrets
)

$ErrorActionPreference = 'Stop'

& (Join-Path $PSScriptRoot 'check.ps1') -Strict:$Strict -StrictSecrets:$StrictSecrets
if ($LASTEXITCODE -ne 0) {
    Write-Error 'Structural check failed.' -ErrorAction Continue
    exit $LASTEXITCODE
}

& (Join-Path $PSScriptRoot 'compile.ps1') `
    -CompilerPath $CompilerPath `
    -KeepBuildDirectory:$KeepBuildDirectory `
    -SkipStructuralCheck

if ($LASTEXITCODE -ne 0) {
    Write-Error 'Compilation failed or could not be executed.' -ErrorAction Continue
    exit $LASTEXITCODE
}

Write-Host 'Verification passed.'
