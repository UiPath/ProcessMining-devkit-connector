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

function Execute-dbt
{
Param ([string]$cmdType)
    try
    {
        Write-Log ("dbt $cmdType START")
        cmd /c "cd /d `"$venvDir\Scripts`" & activate & cd /d `"$Env:DBT_PROFILES_DIR\$appName`" & dbt $cmdType 1> `"$responseFile`" 2>&1"
    }
    catch
    {
        Write-Log ("dbt $cmdType FAILED")
        return -1
    }
    
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

    if($LASTEXITCODE -ne 0)
    {
        Write-Log ("dbt $cmdType returned with error code: " + $LASTEXITCODE)
        return $LASTEXITCODE
    }
    else
    {
        Write-Log ("dbt $cmdType FINISHED")
    }

    if ((Test-Path "$responseFile"))
    {
        Remove-Item $responseFile
    }

}

<# Create a log file in the relative directory of the script if it is not already existent. #>
$scriptDir = $PSScriptRoot
$Logfile = $scriptDir + "\LogFile.log"
$responseFile=$scriptDir + "\response.txt"

Execute-dbt("run")
Execute-dbt("test")