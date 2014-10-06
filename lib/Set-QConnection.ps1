 #used for the ssl cert check   
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
#trust the cert regardless
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
#initialize the variables    
$resp = ""
$outf = ""
$url = "https://qualysapi.qualys.com/api/2.0/fo"

#create a connection to the server
function Open-QualysConnection([string]$username,[string]$password){ 
    if ($username -eq ""){
    $creds = Get-Credential
    $username = $creds.UserName
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($creds.Password)
    $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) 
    }
    $headers = @{"X-Requested-With"="powershell"}
    $uri = "https://qualysapi.qualys.com/api/2.0/fo/session/?action=login&username=$username&password=$password"
    $resp = Invoke-WebRequest -Headers $headers -Uri $uri -Method Post -SessionVariable session
    #holds the cookie for authentication
    $Global:websession = $session
    #check if we got a authentication cookie
    if ($resp.Headers.'Set-Cookie') 
    {
        Write-Host "Login Successful:" + $resp.Headers.'Set-Cookie'.ToString()
    }
    else
    {
        write-host "Login Failed"
    }
}

function Close-QualysConnection{
    try
    {
        $headers = @{"X-Requested-With"="powershell"}  
        $url = "https://qualysapi.qualys.com/api/2.0/fo/session/?action=logout"
        $resp = Invoke-WebRequest -Headers $headers -Uri $url -Method Post -WebSession $websession
        $response = [xml]$resp
        $response.simple_return.response.text
    }
    Catch
    {
        [system.exception]
        Write-error "There was an error attempting logoff"
    }
}

   