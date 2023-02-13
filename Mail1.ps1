# Load the necessary modules

Install-Module -Name MSAL.PS

Import-Module -Name Microsoft.Graph

# Connect to the Microsoft Graph API

$appId = "<YOUR_APP_ID>"

$tenantId = "<YOUR_TENANT_ID>"

$clientSecret = "<YOUR_CLIENT_SECRET>"

$scopes = "https://graph.microsoft.com/.default"

$authResult = Connect-MSALService -AppId $appId -TenantId $tenantId -ClientSecret $clientSecret -Scopes $scopes

$token = Get-MSALAccessToken -AuthResult $authResult

$graphClient = New-Object Microsoft.Graph.GraphServiceClient -ArgumentList ($token)

# Get the first email from your inbox

$email = $graphClient.Me.MailFolders.Inbox.Messages.GetByPage().CurrentPage.First()

# Check if the email has an attachment

if ($email.HasAttachments) {

    Write-Host "Email has attachments"

} else {

    Write-Host "Email has no attachments"

}

