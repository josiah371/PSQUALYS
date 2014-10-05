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

    function Get-QualysScans
    {
    $headers = @{"X-Requested-With"="powershell"} 
     $url = "https://qualysapi.qualys.com/api/2.0/fo/scan/?action=list"
    $resp = Invoke-WebRequest -Headers $headers -Uri $url -Method Post -WebSession $websession
    $Global:scan_data = [xml]$resp.Content
    $scan_data.SCAN_LIST_OUTPUT.Response.SCAN_LIST.SCAN
    }


#Will get the results of the scanning from the API 
#the results are the actual test results not a report
#ref is the scan name in the format of scan/nnnnnnnnnnn.nnnnnn
#Path is where you want to save it
function Get-QualysScansResults([string]$ref,[string]$Path)
    {
    $headers = @{"X-Requested-With"="powershell"} 
     $url = "https://qualysapi.qualys.com/api/2.0/fo/scan/?action=fetch&scan_ref=$ref"
    $resp = Invoke-WebRequest -Headers $headers -Uri $url -Method Post -WebSession $websession
    $resp.Content | Out-File -FilePath $Path
    }

function Get-QualysScanReport([string]$ref,[string]$Path)
    {
    $headers = @{"X-Requested-With"="powershell"} 
    $url = "https://qualysapi.qualys.com/api/2.0/fo/scan/?action=fetch&scan_ref=$ref&mode=brief&output_format=csv&echo_request=1"
    $resp = Invoke-WebRequest -Headers $headers -Uri $url -Method Post -WebSession $websession
    $resp.Content | Out-File -FilePath $Path
    }


function Get-QualysScanRep([string]$ref,[string]$Path)
    {
    $headers = @{"X-Requested-With"="powershell"} 
     $url = "https://qualysapi.qualys.com/api/2.0/fo/scan/?report_type=Scan&outpt_format=csv&report_ref=$ref"
    $resp = Invoke-WebRequest -Headers $headers -Uri $url -Method Post -WebSession $websession
    $resp.Content 
    }