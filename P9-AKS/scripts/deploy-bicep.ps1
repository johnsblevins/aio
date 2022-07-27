Param(
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$environment = "AzureUSGovernment",
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$location = "USGovVirginia",
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$subscriptionId
)

# $environment = "AzureUSGovernment"
# $location = "USGovVirginia"
# $subscriptionId = "f86eed1f-a251-4b29-a8b3-98089b46ce6c"

# Login to Azure Environment
$azcontext = get-azcontext
if( ! $azcontext -or $azcontext.Environment -ne $environment )
{
    Login-AzAccount -Environment $environment
}

# Generate Public/Private Key
ssh-keygen -b 4096
$publickey = Get-Content C:\Users\azureadmin/.ssh/id_rsa.pub

# Deploy Template
$random = ( get-random -Minimum 0 -Maximum 999999 ).tostring('000000') 
Select-AzSubscription $subscriptionId
New-AzDeployment -Name "Deploy-AIO-Azure-AKS-$random" -Location $location -TemplateFile '../bicep/main.bicep' -TemplateParameterFile '../parameters/main.parameters.json' -deploymentid $random -sshRSAPublicKey $publickey