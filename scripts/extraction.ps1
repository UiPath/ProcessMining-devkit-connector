// Configure the variables for the extraction
$URL='YOUR_CDATA_SERVER_URL'
$authtoken='YOUR_AUTHENTICATION_TOKEN'
$job='YOUR_JOB'

$params = @{"JobName"=$job;
 "ExecutionType"="Run";
 "Async"="false";
}

// Execute the extraction
echo "Sending POST request"
Invoke-WebRequest -Headers @{'x-cdata-authtoken'=$authtoken} -Method POST -Body ($params|ConvertTo-Json) -ContentType "application/json" -Uri $URL/api.rsc/executeJob -OutFile executeJob.txt
echo "Finished sending POST request"

// Save the POST request response
$json = Get-Content 'executeJob.txt' | Out-String | ConvertFrom-Json
$successfulExtraction = $false// Insert your logic here to check the status of the extractionforeach($element in $json.value){    if($element.Status -eq "SUCCESS" -And $element.Result -eq $null)    {        $successfulExtraction = $true    }}

// If the extraction is successful
if($successfulExtraction -eq $true)
{
    echo "Successful extraction"
    return 0
}
// If the extraction failed
else
{
    echo "Error in extraction"
    return -1
}