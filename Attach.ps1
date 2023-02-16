# Define the email ID and the attachment directory
$emailId = "Enter your email ID here"
$attachmentDirectory = "Enter the directory path to save attachments here"

# Get the attachments from the email
$attachments = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/me/messages/$emailId/attachments" -Headers @{Authorization = "Bearer $AccessToken"}

# Loop through the attachments and save them to the specified directory
foreach ($attachment in $attachments.value) {
    $fileName = $attachment.name
    $filePath = Join-Path $attachmentDirectory $fileName
    $attachmentBytes = [System.Convert]::FromBase64String($attachment.contentBytes)
    [System.IO.File]::WriteAllBytes($filePath, $attachmentBytes)
}
