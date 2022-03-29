<# Configure if the scripts are in different locations #>
$scriptDir = $PSScriptRoot
$eDir = $scriptDir
$tDir = $scriptDir
$lDir = $scriptDir

<# Extractor #>
$extractionReturnCode = PowerShell -NonInteractive -NoProfile -ExecutionPolicy Bypass -Command "& $eDir\extract_cdata.ps1"
Write-Host "extract_cdata.ps1 exited with exit code $extractionReturnCode"

<# Proceed only if extractor returns 0 or stop if above returns anything else #>
if($extractionReturnCode -ne 0)
{
   return $extractionReturnCode
}

<# Transform #>
$transformReturnCode = PowerShell -NonInteractive -NoProfile -ExecutionPolicy Bypass -Command "& $tDir\transform.ps1"
Write-Host "transform.ps1 exited with exit code $transformReturnCode"

<# Proceed only if transform returns 0 or stop if above returns anything else #>
if($transformReturnCode -ne 0)
{
    return $transformReturnCode
}

<# Load #>
PowerShell -NonInteractive -NoProfile -ExecutionPolicy Bypass -Command "& $lDir\load.ps1"
Write-Host "load.ps1 executed"
