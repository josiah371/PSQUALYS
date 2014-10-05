#Session Options

<#
.Synopsis
   Invoke-ListScans lists vulnerability scans in the user’s account.
.DESCRIPTION
   The VM Scan List API v2 call lists vulnerability
scans in the user’s account. By default the XML output lists scans launched in 
the past 30 days. The GET or POST access method may be used to make a scan list
request. Authentication is required to make a request. See Chapter 2, 
“Authentication Using the V2 APIs.
.EXAMPLE
   -Invoke-ListScans
.EXAMPLE
   TODO
#>
function Invoke-ListScans
{
    [CmdletBinding()]
    [OutputType([xml])]
    Param
    (
        # Action
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateSet('list')]
        [string]$action,

        # echo request {true|false}
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [bool]$echo_request,

        # State - the state of the scan {Running|Paused|Canceled|Finished|Error|Queued|Loading} 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('Running', 'Paused', 'Canceled', 'Finished', 'Error', 'Queued', 'Loading')]
        [string]$state,

        # type {on-demand | Scheduled}
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$type,

        # IP or an IP Range
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('On-Demand', 'Scheduled', 'API')]
        [string]$target,

        # User Login
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$user_login,

        # Param1 2007-09-25T12:28:29Z
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$launched_after_datetime,

        # Param1 2007-09-25T12:28:29Z
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$launched_before_datetime,

        # Show Ags
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [bool]$show_ags,

        # Show OP
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [bool]$show_op,

        # Show Status
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [bool]$show_status,

        # Show Last
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [bool]$show_last,

        # PCI Only
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0) ]
                   [ValidateSet($true)]
        [bool]$pci_only,

         # Scan Type {VM Scan|Compliance Scan|SCAP Scan}
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateSet('VM Scan','Compliance Scan','SCAP Scan')]
        $API_Scan_Type
    )

     Begin
    {
       $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
       $url2= switch ($API_Scan_Type)
                {
                 "vm*" {"api/2.0/fo/scan"}
                 "comp*" {"api/2.0/fo/scan/compliance"}
                 "SCAP*" {"api/2.0/fo/scan/scap"}
                }
    }
    Process
    {
    $url = "$qualys_url/$url_2/?action=$action"
        if ($echo_request){ $url = "$url&echo_request=1"}
        if ($scan_ref){$url = "$url&scan_ref=$scan_ref"}
        if ($state){$url = "$url&state=$state"}
        if ($type){$url = "$url&type=$type"}
        if ($target){$url = "$url&target=$target"}
        if ($userlogin){$url = "$url&userlogin=$userlogin"}
        if ($launched_after_datetime){$url = "$url&launched_after_datetime=$launched_after_datetime"}
        if ($launched_before_datetime){$url = "$url&launched_before_datetime=$launched_before_datetime"}
        if ($show_args){$url = "$url&show_args=1"}
        if ($show_op){$url = "$url&show_op=1"}
        if ($show_status){$url = "$url&show_status=1"}
        if ($pci_only){$url = "$url&pci_only=1"}
        
       
        $resp = Invoke-WebGetRequest($url) 
        return [xml]$resp
    }
    End
    {
    }
}

<#
.Synopsis
   Invoke-ManageScans allows for the Management of scans
.DESCRIPTION
   Manage Scans allows for the management of scans and allows users to take
actions on vulnerability scans in their account, like cancel, pause, resume, delete and
fetch completed scan results
.EXAMPLE
   Invoke-ManageScans
.EXAMPLE
   TODO
#>
function Invoke-ManageScans
{
    [CmdletBinding()]
    [OutputType([xml])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [validateSet('cancel', 'pause', 'resume')]
        [string]$action,

         # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [string]$scan_ref,

        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet($true)]
        [bool]$echo_request,

        
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        [ValidateSet('VM Scan','Compliance Scan','SCAP Scan')]
        [string]$API_Scan_Type

    )

    Begin
    {
       $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
       $url2= switch ($API_Scan_Type)
                {
                 "vm*" {"api/2.0/fo/scan"}
                 "comp*" {"api/2.0/fo/scan/compliance"}
                 "SCAP*" {"api/2.0/fo/scan/scap"}
                }
    }
    Process
    {
        $url = "$qualys_url/$url_2/?action=$action&scan_ref=$scan_ref"
        if ($echo_request){ $url = "$url&echo_request=1"}

        $resp = Invoke-WebPostRequest($url) 
        return [xml]$resp
    }
    End
    {

    }
}

<#
.Synopsis
   Invoke-DownloadScanResults - Using the Download Scan Results will allow for the scan log to be downloaded
.DESCRIPTION
   Allows the user to download the raw scan results data. It does not include
   the actual test for the output but rather the output of the checks.
.EXAMPLE
   Invoke-DownloadScanResults -action fetch -scan_ref scan/nnnnnnnnnnn.nnnnnn -API_scan_type "VM Scan"
.EXAMPLE
   Invoke-DownloadScanResults -action fetch -scan_ref scan/nnnnnnnnnnn.nnnnnn -mode brief -API_scan_type "Compliance Scan"
#>
function Invoke-DownloadScanResults
{
[CmdletBinding()]
    [OutputType([xml])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [validateSet('fetch')]
        [string]$action,

         # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [string]$scan_ref,

        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet($true)]
        [bool]$echo_request,

                 # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        [string]$ips,

                 # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=4)]
                   [ValidateSet('brief', 'extended')]
        [string]$mode,

                 # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=5)]
                   [ValidateSet('csv', 'json')]
        [string]$output_format,

         # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        [ValidateSet('VM Scan','Compliance Scan','SCAP Scan')]
        [string]$API_Scan_Type
    )

    Begin
    {
       $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
       $url2= switch ($API_Scan_Type)
                {
                 "vm*" {"api/2.0/fo/scan"}
                 "comp*" {"api/2.0/fo/scan/compliance"}
                 "SCAP*" {"api/2.0/fo/scan/scap"}
                }
    }
    Process
    {
         {
         #action and scan_ref are mandatory
        $url = "$qualys_url/$url_2/?action=$action&scan_ref=$scan_ref"
        if ($echo_request){ $url = "$url&echo_request=1"}
        if ($ips){$url = "$url&ips=$ips"}
        if ($type){$url = "$url&type=$type"}
        if ($mode){$url = "$url&mode=$mode"}
        if ($output_format){$url = "$url&output_format=$output_format"}
                
       #execute the web request
        $resp = Invoke-WebGetRequest($url) 
        return [xml]$resp
    }
    }
    End
    {

    }
    }

<#
.Synopsis
   Invoke-SharePCIScan - Share PCI Scan results with a Merchant portal
.DESCRIPTION
   The function is used to share a PCI Compliance scan results with the PCI portal of your choice.
.EXAMPLE
   Invoke-DownloadScanResults -action share -echo_request $true -scan_ref scan/nnnnnnnnnnn.nnnnnn -merchant_username BOA
.EXAMPLE
   Invoke-DownloadScanResults -action share -scan_ref scan/nnnnnnnnnnn.nnnnnn -merchant_username BOA
#>
function Invoke-SharePCIScan
{
    [CmdletBinding()]
    [OutputType([xml])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [validateSet('share', 'status')]
        [string]$action,

         # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [string]$scan_ref,

        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet($true)]
        [bool]$echo_request,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [bool]$merchant_username,

        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        [ValidateSet('VM Scan','Compliance Scan','SCAP Scan')]
        [string]$API_Scan_Type

    )

    Begin
    {
       $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
       $url2= switch ($API_Scan_Type)
                {
                 "vm*" {"api/2.0/fo/scan"}
                 "comp*" {"api/2.0/fo/scan/compliance"}
                 "SCAP*" {"api/2.0/fo/scan/scap"}
                }
    }
    Process
    {
        $url = "$qualys_url/$url_2/?action=$action&scan_ref=$scan_ref&merchant_username=$merchant_username"
        if ($echo_request){ $url = "$url&echo_request=1"}

        $post = switch ($action)
                {
                 "status" {$true}
                 "share" {$false}   
                }
        if ($post)
        {

        $resp = Invoke-WebPostRequest($url) 
        return [xml]$resp
        }
        else{
        $resp = Invoke-WebGetRequest($url) 
        return [xml]$resp
        }
    }
    End
    {

    }
}

<#
.Synopsis
   Invoke-LaunchScan - Launch a VM Scan is used to launch vulnerability scans in the user’s account. 
.DESCRIPTION
   A major benefit of using the new Launch Scan API v2 is that it is asynchronous. When
you make a request to launch a scan using this API, the service will return a scan
reference ID right away and the call will quit without waiting for the complete scan
results.
.EXAMPLE
   Invoke-SharePCIScan -action share -echo_request $true -scan_ref scan/nnnnnnnnnnn.nnnnnn -merchant_username BOA
.EXAMPLE
   Invoke-SharePCIScan -action share -scan_ref scan/nnnnnnnnnnn.nnnnnn -merchant_username BOA
#>
function Invoke-LaunchScan
{
 [CmdletBinding()]
    [OutputType([xml])]
    Param
    (
# Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [validateSet('launch')]
        [string]$action,

         # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [string]$scan_ref,

        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet($true)]
        [bool]$echo_request,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$scan_title,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet('assets','tags')]
        [string]$target_from,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$ip,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$asset_groups,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$asset_group_ids,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$exclude_ip_per_scan,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet('any', 'all')]
        [string]$tag_include_selector,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet('any', 'all')]
        [string]$tag_exclude_selector,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet('id', 'any')]
        [string]$tag_set_by,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$tag_set_include,
        
        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$tag_set_exclude,
        
        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet($true)]
        [bool]$use_ip_nt_range_tags,

        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$iscanner_id,
        
        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$iscanner_name,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet($true)]
        [bool]$default_scanner,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
                   [ValidateSet($true)]
        [bool]$scanners_in_ag,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$option_title,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$option_id,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$runtime_http_header,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$connector_name,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$ec2_endpoint,

                # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$ip_network_id,

                 # Scan Type {VM Scan|Compliance Scan|SCAP Scan}
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateSet('VM Scan','Compliance Scan')]
        $API_Scan_Type
        )

    
     Begin
    {
       $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
       $url2= switch ($API_Scan_Type)
                {
                 "vm*" {"api/2.0/fo/scan"}
                 "comp*" {"api/2.0/fo/scan/compliance"}
                 }
    }
    Process
    {
        $url = "$qualys_url/$url_2/?action=$action&scan_ref=$scan_ref"
        if ($echo_request){ $url = "$url&echo_request=1"}
        if ($scan_title) {"$url&scan_title=$scan_title"}
        if ($target_from) {"$url&target_from=$target_from"}
        if ($ip) {"$url&ip=$ip"}
        if ($asset_groups) {"$url&asset_groups=$asset_groups"}
        if ($asset_group_ids) {"$url&asset_group_ids=$asset_group_ids"}
        if ($exclude_ip_per_scan) {"$url&exclude_ip_per_scan=$exclude_ip_per_scan"}
        if ($tag_include_selector) {"$url&tag_include_selector=$tag_include_selector"}
        if ($tag_exclude_selector) {"$url&tag_exclude_selector=$tag_exclude_selector"}
        if ($tag_set_by) {"$url&tag_set_by=$tag_set_by"}
        if ($tag_set_include) {"$url&tag_set_include=$tag_set_include"}
        if ($tag_set_exclude) {"$url&tag_set_exclude=$tag_set_exclude"}
        if ($use_ip_nt_range_tags) {"$url&use_ip_nt_range_tags=1"}
        if ($iscanner_id) {"$url&iscanner_id=$iscanner_id"}
        if ($iscanner_name) {"$url&iscanner_name=$iscanner_name"}
        if ($default_scanner) {"$url&default_scanner=1"}
        if ($scanners_in_ag) {"$url&scanners_in_ag=1"}
        if ($option_title) {"$url&option_title=$option_title"}
        if ($option_id) {"$url&option_id=$option_id"}
        if ($runtime_http_header) {"$url&runtime_http_header=$runtime_http_header"}
        if ($connector_name) {"$url&connector_name=$connector_name"}
        if ($ec2_endpoint) {"$url&ec2_endpoint=$ec2_endpoint"}
        if ($ip_network_id) {"$url&ip_network_id=$ip_network_id"}

             
        $resp = Invoke-WebPostRequest($url) 
        return [xml]$resp
        
    }
    End
    {

    }




}


<# ----------------------------------------------------#>
<#
.Synopsis
   Execute-WebGetRequest - Used to execute a Get against the Qualys APIv2
.DESCRIPTION
   Long description
.EXAMPLE
   $val = Execute-WebGetRequest(http://qualysapiurl.com/)
#>
function Invoke-WebGetRequest($url)
{
$headers = @{"X-Requested-With"="powershell"} 
return $(Invoke-WebRequest -Headers $headers -Uri $url -Method Get -WebSession $websession)
}

<#
.Synopsis
   Execute-WebPostRequest - Used to execute a Post against the Qualys APIv2
.DESCRIPTION
   Long description
.EXAMPLE
   $val = Execute-WebPostRequest(http://qualysapiurl.com/)
#>
function Invoke-WebPostRequest($url)
{
$headers = @{"X-Requested-With"="powershell"} 
return $(Invoke-WebRequest -Headers $headers -Uri $url -Method Post -WebSession $websession)
}
<# ----------------------------------------------------#>