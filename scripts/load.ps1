<# Create a log file in the relative directory of the script if it is not already existent. #>
$scriptDir = $PSScriptRoot
$Logfile = $scriptDir + "\LogFile.log"
$outputFile = $scriptDir+ "\response.txt"

<# Custom function for appending text to a file #>
function Write-Log
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("dd/MM/yyyy HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Add-content $LogFile -value $LogMessage
}

$PM_installation= $Env:PM_INSTALLATION  
  
$SettingsObject = Get-Content -Path "$scriptDir\config.json" | ConvertFrom-Json
$environment= $SettingsObject.pm_environment

<# Execute the cache generation #>
Write-log ("Start cache generation")

cmd /c "$PM_installation\builds\processgold.bat" -DataServer -env $environment -ccdb app=* o=* refreshmvncaches=true > $outputfile 2>&1 

try
{   
    $outputText=Get-Content -Path ($outputfile)
    if($outputText -ne $null)
    {
        Write-Log ($outputText)
    }
    if(Test-Path "$outputfile")
    {
        Remove-Item $outputfile
    }
}
catch
{
    Write-Log ("Failed fetching the cache generation output file")
}      

Write-log ("End of cache generation")
