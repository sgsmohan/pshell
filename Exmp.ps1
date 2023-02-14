# Import the Microsoft.Graph.Authentication and Microsoft.Graph.PowerShell modules
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.PowerShell

# Set the values for the client ID, client secret, and tenant ID for your app registration in Azure Active Directory
$clientId = "your-client-id"
$clientSecret = "your-client-secret"
$tenantId = "your-tenant-id"

# Create a new credential object using the client ID and client secret
$credential = New-Object Microsoft.Graph.Authentication.DeviceCodeCredential($clientId, $tenantId, {
    $null
}, {
    Write-Host $_.Message
})

# Connect to Microsoft Graph API using the credential object and the desired API version
Connect-MgGraph -Credential $credential -ApiVersion "v1.0"
