# Define the shared mailbox email address, email ID, attachment directory, and archive folder ID
$sharedMailbox = "Enter the shared mailbox email address here"
$emailId = "Enter the email ID of the email in the shared mailbox here"
$attachmentDirectory = "Enter the directory path to save attachments here"
$archiveFolderId = "Enter the ID of the shared mailbox's archive folder here"

# Authenticate using a user account with access to the shared mailbox
$clientId = "Enter your client ID here"
$clientSecret = "Enter your client secret here"
$tenantId = "Enter your tenant ID here"

$scopes = "https://graph.microsoft.com/.default"
$tokenBody = @{
    client_id     = $clientId
    client_secret = $clientSecret
    scope         = $scopes
    grant_type    = "client_credentials"
}

$tokenResponse = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -Body $tokenBody
$accessToken = $tokenResponse.access_token

# Get the attachments from the email in the shared mailbox
$attachments = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/users/$sharedMailbox/messages/$emailId/attachments" -Headers @{Authorization = "Bearer $AccessToken"}

# Loop through the attachments and save them to the specified directory
foreach ($attachment in $attachments.value) {
    $fileName = $attachment.name
    $filePath = Join-Path $attachmentDirectory $fileName
    $attachmentBytes = [System.Convert]::FromBase64String($attachment.contentBytes)
    [System.IO.File]::WriteAllBytes($filePath, $attachmentBytes)
}

# Set the email's isRead property to true and move it to the shared mailbox's archive folder
$jsonBody = @{
    isRead = $true
    parentFolderId = $archiveFolderId
} | ConvertTo-Json

$patchUrl = "https://graph.microsoft.com/v1.0/users/$sharedMailbox/messages/$emailId"
Invoke-RestMethod -Method PATCH -Uri $patchUrl -Headers @{Authorization = "Bearer $AccessToken"} -Body $jsonBody
