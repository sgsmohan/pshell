# Authenticate with Microsoft Graph API
$clientId = "<Your client ID>"
$clientSecret = "<Your client secret>"
$tenantId = "<Your tenant ID>"
$scopes = "https://graph.microsoft.com/.default"
$body = @{grant_type="client_credentials";scope=$scopes;client_id=$clientId;client_secret=$clientSecret}
$authResponse = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -Body $body
$accessToken = $authResponse.access_token

# Get the email messages from a different mailbox
$headers = @{
    "Authorization" = "Bearer $accessToken"
}
$otherMailboxId = "<Mailbox ID or email address>"
$emailMessages = Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/v1.0/users/$otherMailboxId/messages" -Headers $headers

# Do something with the email messages
foreach ($email in $emailMessages.value) {
    Write-Host "Subject: $($email.subject)"
}
