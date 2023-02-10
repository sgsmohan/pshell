# Load the necessary modules

Import-Module -Name Microsoft.Graph

Import-Module -Name Microsoft.Graph.Auth

Import-Module -Name Microsoft.Graph.Exchange

# Connect to the Microsoft Graph API

$appId = "<YOUR_APP_ID>"

$tenantId = "<YOUR_TENANT_ID>"

$clientSecret = "<YOUR_CLIENT_SECRET>"

$scopes = "https://graph.microsoft.com/.default"

$authProvider = New-Object Microsoft.Graph.Auth.ConfidentialClientApplicationAuthProvider -ArgumentList $appId, $tenantId, $clientSecret

$graphClient = New-Object Microsoft.Graph.GraphServiceClient -ArgumentList $authProvider, $scopes

# Get the first email from your inbox

$email = $graphClient.Me.MailFolders.Inbox.Messages.GetByPage().CurrentPage.First()

# Check if the email has an attachment

if ($email.HasAttachments) {

    Write-Host "Email has attachments"

} else {

    Write-Host "Email has no attachments"

}

