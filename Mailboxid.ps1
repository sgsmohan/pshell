# Define the shared mailbox email address and authentication details
$sharedMailbox = "Enter the shared mailbox email address here"
$clientId = "Enter your client ID here"
$clientSecret = "Enter your client secret here"
$tenantId = "Enter your tenant ID here"

# Get an access token using client credentials flow
$scopes = "https://graph.microsoft.com/.default"
$tokenBody = @{
    client_id     = $clientId
    client_secret = $clientSecret
    scope         = $scopes
    grant_type    = "client_credentials"
}
$tokenResponse = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -Body $tokenBody
$accessToken = $tokenResponse.access_token

# Get the ID of the archive folder in the shared mailbox
$mailFolders = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/users/$sharedMailbox/mailFolders?\$filter=displayName eq 'Archive'" -Headers @{Authorization = "Bearer $accessToken"}
$archiveFolderId = $mailFolders.value.id
