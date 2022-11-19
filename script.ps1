## Change
##
z##
Function Login-MLOAzureAD {
#https://docs.microsoft.com/en-us/graph/auth-v2-service
    param ( 
        [String]$TenantId,
        [System.Management.Automation.PSCredential]$Credential
    )
    Try {
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Credential.Password)
        $AppIdSecret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
        $AzADAuthBody = @{
            "client_id" = $($Credential.Username)
            "client_secret" = $AppIdSecret
            "scope" = "https://graph.microsoft.com/.default"
            "grant_type" = "client_credentials"
        }
        $AzADAuthResponse = Invoke-RestMethod -Method POST -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Body $AzADAuthBody
        $AzADAccessToken = $($AzADAuthResponse.access_token)
        return $AzADAccessToken
    } Catch {
        "Unable to Login to Azure Active Directory"
        throw
    }
}
Function Login-MLOAzureADDelegated {
    #https://docs.microsoft.com/en-us/graph/auth-v2-service
        param ( 
            [String]$TenantId,
            [System.Management.Automation.PSCredential]$PrincipalCredential,
            [System.Management.Automation.PSCredential]$UserCredential
        )
        Try {
            $PrincipalBSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($PrincipalCredential.Password)
            $AppIdSecret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($PrincipalBSTR)
            $UserBSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($UserCredential.Password)
            $UserSecret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($UserBSTR)
            $AzADAuthBody = @{
                Grant_Type    = "Password"
                client_Id     = $($PrincipalCredential.Username)
                Client_Secret = $AppIdSecret
                Username      = $($UserCredential.Username)
                Password      = $UserSecret
                Scope         = "https://graph.microsoft.com/.default"
            } 
            $AzADAuthResponse = Invoke-RestMethod -Method POST -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"  -Body $AzADAuthBody
            $AzADAccessToken = $($AzADAuthResponse.access_token)
            return $AzADAccessToken
        } Catch {
            "Unable to Login to Azure Active Directory"
            throw
        }
    }

Function Login-MLOAzureRM {
    #https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad-app
        param ( 
            [String]$TenantId,
            [ValidateSet ("https://management.core.windows.net/","https://storage.azure.com/")]
            [String]$Resource,
            [System.Management.Automation.PSCredential]$Credential
        )
        Try {
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Credential.Password)
            $AppIdSecret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
            $ArmResourceAuthBody = @{
                "client_id" = $($Credential.Username)
                "client_secret" = $AppIdSecret
                "resource" = $Resource
                "grant_type" = "client_credentials"
            }
            $ArmResourceAuthResponse = Invoke-RestMethod -Method POST -Uri "https://login.microsoftonline.com/$TenantId/oauth2/token" -Body $ArmResourceAuthBody
            $ArmResourceAccessToken = $($ArmResourceAuthResponse.access_token)
            return $ArmResourceAccessToken
        } Catch {
            "Unable to Login to Azure Resource Manager"
            throw
        }
    }
