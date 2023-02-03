$directory = "C:\Files"

$files = Get-ChildItem $directory

foreach ($file in $files) {

    $filePath = $file.FullName

    $lastWriteTime = $file.LastWriteTime

    $timeStamp = $lastWriteTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

    Invoke-WebRequest -Method POST -Uri "https://{your-dynatrace-instance}/api/v1/events" `

        -Headers @{

            "Authorization" = "Api-Token {your-api-token}"

            "Content-Type" = "application/json"

        } `

        -Body (@{

            "eventType" = "Custom Event";

            "eventName" = "File Last Write Time";

            "timestamp" = $timeStamp;

            "properties" = @{

                "fileName" = $filePath;

                "lastWriteTime" = $lastWriteTime;

            }

        } | ConvertTo-Json)

}
