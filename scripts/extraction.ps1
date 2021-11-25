<# Configure the variables for the extraction #>
$URL='YOUR_CDATA_SERVER_URL'
$authtoken='YOUR_AUTHENTICATION_TOKEN'
$job='YOUR_JOB'

<# Custom function for appending text to a file #>
function Write-Log
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("dd/MM/yyyy HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Add-content $LogFile -value $LogMessage
}

<# Create a log file in the relative directory of the script if it is not already existent. #>
$scriptDir = $PSScriptRoot
$Logfile = $scriptDir + "\LogFile.log"
try
{
    if (!(Test-Path "$Logfile"))
    {
       New-Item -name $Logfile -type "file"
    }
}
catch
{
    echo "Log file not found. Creating it."
}

$params = @{"JobName"=$job;
 "ExecutionType"="Run";
 "Async"="false";
}

<# Execute the extraction #>
Write-Log("Start extraction")
try
{
    $json = Invoke-RestMethod -Headers @{'x-cdata-authtoken'=$authtoken} -Method POST -Body ($params|ConvertTo-Json) -ContentType "application/json" -Uri $URL/api.rsc/executeJob
    Write-Log ("Finished extraction")
}
catch
{
    Write-Log("Failed to perform the extraction. Please check your settings or look into the 'Logging & History' of your job!")
    return -2
}

$successfulExtraction = $false
<# Insert your logic here to check the status of the extraction #>
foreach($element in $json.value)
{
    if($element.Status -eq "SUCCESS" -And $element.Result -eq $null)
    {
        $successfulExtraction = $true
    }
}

<# If the extraction is successful #>
if($successfulExtraction -eq $true)
{
    Write-Log("Extraction SUCCESSFUL for " + $job)
    return 0
}
<# If the extraction failed #>
else
{
    Write-Log("Extraction FAILED for " + $job)
    return -1
}