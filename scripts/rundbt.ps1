$venvDir="YOUR_PYTHON_VIRTUAL_ENVIRONMENT_PATH"
$appName="YOUR_DBT_PROJECT_PATH"

<# Custom function for appending text to a file #>
function Write-Log
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("dd/MM/yyyy HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Add-content $LogFile -value $LogMessage
}

<# Custom function for appending the contents of a file to the log file and then delete the source #>
function Response-Append
{
Param ([string]$responseFile)
try
    {   
        $responseText=Get-Content -Path ($responseFile)
        if($responseText -ne $null)
        {
            Write-Log ($responseText)
        }
        if(Test-Path "$responseFile")
        {
            Remove-Item $responseFile
        }
    }
catch
    {
        Write-Log ("Failed fetching the dbt response")
    }
}

<# Create a log file in the relative directory of the script if it is not already existent. #>
$scriptDir = $PSScriptRoot
$Logfile = $scriptDir + "\LogFile.log"
try
{
    <# Wait for 1 second for the instance to have time to write the previous files#>
    Start-Sleep -s 1
    if (!(Test-Path "$Logfile"))
    {
       New-Item -name $Logfile -type "file"
    }
}
catch
{
    echo "Log file not found. Creating it."
}
New-Item $responseFile -ItemType file
try
{
    Write-Log ("dbt run START")
    if ((Test-Path "$responseFile"))
    {
        Clear-Content $responseFile
    }
    else
    {
        New-Item -name $responseFile -type "file"
    }
    cmd /c "cd /d `"$venvDir\Scripts`" & activate & cd /d `"$Env:DBT_PROFILES_DIR\$appName`" & dbt run -m Sales_order_items_base 1> `"$responseFile`" 2>&1"
}
catch
{
    Write-Log ("dbt run FAILED")
    return -1
}

<# Write the dbt run response to the logfile #>
$responseFile=$scriptDir + "\response.txt"
Response-Append($responseFile)

if($LASTEXITCODE -ne 0)
{
    Write-Log ("dbt run returned with error code: " + $LASTEXITCODE)
    return $LASTEXITCODE
}
else
{
    Write-Log ("dbt run FINISHED")
}

try
{
    Write-Log ("dbt test START")
    if ((Test-Path "$responseFile"))
    {
        Clear-Content $responseFile
    }
    else
    {
        New-Item -name $responseFile -type "file"
    }
    cmd /c "cd /d `"$venvDir\Scripts`" & activate & cd /d `"$Env:DBT_PROFILES_DIR\$appName`" & dbt test -m Sales_order_items_base 1> `"$responseFile`" 2>&1"
}
catch
{
    Write-Log ("dbt test FAILED")
    return -2
}

<# Write the dbt test response to the logfile #>
Response-Append($responseFile)

if($LASTEXITCODE -ne 0)
{
    Write-Log ("dbt test returned with error code: " + $LASTEXITCODE)
    return $LASTEXITCODE
}
else
{
    Write-Log ("dbt test FINISHED")
}