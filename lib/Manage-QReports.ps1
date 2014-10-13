#Reports Function
#$url2 = "api/2.0/fo/report"

<#
.Synopsis
   Invoke-ListReports
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-ListReports
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # echo request {true|false} default is false
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$id,

        # State - the state of the scan {Running|Submitted|Canceled|Finished|Errors} 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('Running', 'Submitted', 'Canceled', 'Finished', 'Errors')]
        [string]$state,

        # 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$user_login,

        # 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [string]$expires_before_datetime
    )

    Begin
    {
       $url2 = "api/2.0/fo/report"
       $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
       
               
    }
    Process
    {
    $url = "$qualys_url/$url_2/?action=list"
        if ($echo_request){ $url = "$url&echo_request=1"}
        if ($id){$url = "$url&id=$id"}
        if ($state){$url = "$url&state=$state"}
        if ($userlogin){$url = "$url&userlogin=$userlogin"}
        if ($expires_before_datetime){$url = "$url&expires_before_datetime=$expires_before_datetime"}
        
              
        $resp = Invoke-WebGetRequest($url) 
        return [xml]$resp
    }
    End
    {
    }
}

<#
.Synopsis
   Invoke-ManageReports
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-ManageReports
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Action - {Cancel|Delete}
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateSet('cancel', 'delete')]
        [string]$action,

        # echo request {true|false} default is false
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID Number
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$id
    )

      Begin
    {
       $url2 = "api/2.0/fo/report"
       $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"         
    }
    Process
    {
    $url = "$qualys_url/$url_2/?action=$action&id=$id"
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
   Invoke-DownloadReport
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-DownloadReport
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # echo request {true|false} default is false
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID Number
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$id
    )

    Begin
    {
        $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
        $url2 = "api/2.0/fo/report"
    }
    Process
    {
    $url = "$qualys_url/$url_2/?action=fetch&id=$id"
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
   Invoke-LaunchMapReport
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-LaunchMapReport
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # echo request {true|false} default is false
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID Number
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$template_id,

         # Report Title
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$report_title,

        # pdf Password
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$pdf_password,

        # Reciepient Group
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$recipient_group,

        # Hide Header
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$hide_header,

        # Use Tags
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$use_tags,

        # Tags to Include Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_include_selector,
        
        # Tags to Exclude Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_exclude_selector,

        # Tags set by
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('id','name')]
        [string]$tag_set_by,

        
        # Tags set include
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_include,

        
        # Tags set exclude
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_exclude,

         #---------MAP REPORT------------#
       
         # Output_Format
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
                   [validateset('pdf','html','mht','xml','csv','docx')]
        [string]$Output_format,

         # Domain
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$Domain,

        # IP Restriction
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        [string]$ip_restriction,

         # report_refs
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=4)]
        [string]$report_refs


    )

    Begin
    {
        $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
        $url2 = "api/2.0/fo/report"
    }
    Process
    {
   #Map Specific
    $url = "$qualys_url/$url_2/?action=launch&template_id=$template_id&report_type=Map&output_format=$output_format&domain=$domain&report_refs=$report_refs"
    if ($ip_restriction) {$url = "$url&ip_restriction=$ip_restriction"}

        #neutral
        if ($echo_request){ $url = "$url&echo_request=1"}
        if ($template_id){ $url = "$url&template_id=$template_id" }
        if ($report_title){ $url = "$url&report_title=$report_title" }
        if ($pdf_password){ $url = "$url&pdf_password=$pdf_password" }
        if ($recipient_group){ $url = "$url&recipient_group=$recipient_group" }
        if ($hide_header){ $url = "$url&hide_header=1" }
        if ($use_tags){ $url = "$url&use_tags=1" }
        if ($tag_include_selector){ $url = "$url&tag_include_selector=$tag_include_selector" }
        if ($tag_exclude_selector){ $url = "$url&tag_exclude_selector=$tag_exclude_selector" }
        if ($tag_set_by){ $url = "$url&tag_set_by=$tag_set_by" }
        if ($tag_set_include){ $url = "$url&tag_set_include=$tag_set_include" }
        if ($tag_set_exclude){ $url = "$url&tag_set_exclude=$tag_set_exclude" }

        
        $resp = Invoke-WebPostRequest($url) 
        return [xml]$resp
    }
    End
    {
    }
}

<#
.Synopsis
   Invoke-LaunchScanReport
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-LaunchScanReport
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # echo request {true|false} default is false
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID Number
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$template_id,

         # Report Title
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$report_title,

        # pdf Password
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$pdf_password,

        # Reciepient Group
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$recipient_group,

        # Hide Header
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$hide_header,

        # Use Tags
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$use_tags,

        # Tags to Include Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_include_selector,
        
        # Tags to Exclude Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_exclude_selector,

        # Tags set by
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('id','name')]
        [string]$tag_set_by,

        
        # Tags set include
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_include,

        
        # Tags set exclude
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_exclude,

         #---------SCAN REPORT------------#
       
         # Output_Format
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
                   [validateset('pdf','html','mht','xml','csv')]
        [string]$Output_format,

        # IP Restriction (optional with Manual Scan - Not allowed with Automatic)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        [string]$ip_restriction,

        # report_refs
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=4)]
        [string]$report_refs,

        # IPs (optional with Automatic Scan - Not allowed with Manual)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=4)]
        [string]$ips,

        # IP Network ID (optional with Automatic Scan - Not allowed with Manual)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=4)]
        [string]$ips_network_id,

        # Asset Group IDs (optional with Automatic Scan - Not allowed with Manual)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=4)]
        [string]$asset_group_ids
    )

    Begin
    {
        $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
        $url2 = "api/2.0/fo/report"
    }
    Process
    {
   #Scan Specific
    $url = "$qualys_url/$url_2/?action=launch&template_id=$template_id&report_type=Scan&output_format=$output_format&report_refs=$report_refs"
    if ($ip_restriction) {$url = "$url&ip_restriction=$ip_restriction"}
    if ($ips) {$url = "$url&ips=$ips"}
    if ($ips_network_id) {$url = "$url&ip_network_id=$ip_network_id"} 
    if ($asset_group_ids) {$url = "$url&asset_group_ids=$asset_group_ids"}

    #neutral
    if ($echo_request){ $url = "$url&echo_request=1"}
    if ($template_id){ $url = "$url&template_id=$template_id" }
    if ($report_title){ $url = "$url&report_title=$report_title" }
    if ($pdf_password){ $url = "$url&pdf_password=$pdf_password" }
    if ($recipient_group){ $url = "$url&recipient_group=$recipient_group" }
    if ($hide_header){ $url = "$url&hide_header=1" }
    if ($use_tags){ $url = "$url&use_tags=1" }
    if ($tag_include_selector){ $url = "$url&tag_include_selector=$tag_include_selector" }
    if ($tag_exclude_selector){ $url = "$url&tag_exclude_selector=$tag_exclude_selector" }
    if ($tag_set_by){ $url = "$url&tag_set_by=$tag_set_by" }
    if ($tag_set_include){ $url = "$url&tag_set_include=$tag_set_include" }
    if ($tag_set_exclude){ $url = "$url&tag_set_exclude=$tag_set_exclude" }

        
        $resp = Invoke-WebPostRequest($url) 
        return [xml]$resp
    }
    End
    {
    }
}

<#
.Synopsis
   Invoke-LaunchRemediationReport
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-LaunchRemediationReport
{
     [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # echo request {true|false} default is false
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID Number
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$template_id,

         # Report Title
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$report_title,

        # pdf Password
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$pdf_password,

        # Reciepient Group
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$recipient_group,

        # Hide Header
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$hide_header,

        # Use Tags
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$use_tags,

        # Tags to Include Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_include_selector,
        
        # Tags to Exclude Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_exclude_selector,

        # Tags set by
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('id','name')]
        [string]$tag_set_by,

        
        # Tags set include
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_include,

        
        # Tags set exclude
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_exclude,

        #----------Remediation Report----------#

        # IPs 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$ips,

        # IP Network ID 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$assignee_type,

        # Asset Group IDs 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$asset_group_ids
        )
    
    Begin
    {
        $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
        $url2 = "api/2.0/fo/report"
    }
    Process
    {
   #Remediation Report Specific
    $url = "$qualys_url/$url_2/?action=launch&template_id=$template_id&report_type=Remediation&output_format=$output_format"
    if ($asset_group_ids) {$url = "$url&asset_group_ids=$asset_group_ids"}
    if ($assignee_type) {$url = "$url&assignee_type=$assignee_type"} 
    if ($ips) {$url = "$url&ips=$ips"}


    #neutral
    if ($echo_request){ $url = "$url&echo_request=1"}
    if ($template_id){ $url = "$url&template_id=$template_id" }
    if ($report_title){ $url = "$url&report_title=$report_title" }
    if ($pdf_password){ $url = "$url&pdf_password=$pdf_password" }
    if ($recipient_group){ $url = "$url&recipient_group=$recipient_group" }
    if ($hide_header){ $url = "$url&hide_header=1" }
    if ($use_tags){ $url = "$url&use_tags=1" }
    if ($tag_include_selector){ $url = "$url&tag_include_selector=$tag_include_selector" }
    if ($tag_exclude_selector){ $url = "$url&tag_exclude_selector=$tag_exclude_selector" }
    if ($tag_set_by){ $url = "$url&tag_set_by=$tag_set_by" }
    if ($tag_set_include){ $url = "$url&tag_set_include=$tag_set_include" }
    if ($tag_set_exclude){ $url = "$url&tag_set_exclude=$tag_set_exclude" }

        
        $resp = Invoke-WebPostRequest($url) 
        return [xml]$resp
    }
    End
    {
    }
}

<#
.Synopsis
   Invoke-LaunchComplianceReport
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-LaunchComplianceReport
{
     [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # echo request {true|false} default is false
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID Number
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$template_id,

         # Report Title
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$report_title,

        # pdf Password
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$pdf_password,

        # Reciepient Group
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$recipient_group,

        # Hide Header
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$hide_header,

        # Use Tags
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$use_tags,

        # Tags to Include Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_include_selector,
        
        # Tags to Exclude Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_exclude_selector,

        # Tags set by
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('id','name')]
        [string]$tag_set_by,

        
        # Tags set include
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_include,

        
        # Tags set exclude
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_exclude,

        #----------Remediation Report----------#

        # IPs 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$ips,

        # Report Refs - IS REQUIRED FOR A PCI REPORT - NOT VALID FOR OTHER TYPES 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$report_refs,

        # Asset Group IDs 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$asset_group_ids,

        # Output Format - mht is not valid for PCI Report
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('pdf', 'html', 'mht')]
        [string]$output_format
        )
        
    
    Begin
    {
        $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
        $url2 = "api/2.0/fo/report"
    }
    Process
    {
   #Remediation Report Specific
    $url = "$qualys_url/$url_2/?action=launch&template_id=$template_id&report_type=Compliance&output_format=$output_format"
    if ($asset_group_ids) {$url = "$url&asset_group_ids=$asset_group_ids"}
    if ($report_refs) {$url = "$url&report_refs=$report_refs"} 
    if ($ips) {$url = "$url&ips=$ips"}


    #neutral
    if ($echo_request){ $url = "$url&echo_request=1"}
    if ($template_id){ $url = "$url&template_id=$template_id" }
    if ($report_title){ $url = "$url&report_title=$report_title" }
    if ($pdf_password){ $url = "$url&pdf_password=$pdf_password" }
    if ($recipient_group){ $url = "$url&recipient_group=$recipient_group" }
    if ($hide_header){ $url = "$url&hide_header=1" }
    if ($use_tags){ $url = "$url&use_tags=1" }
    if ($tag_include_selector){ $url = "$url&tag_include_selector=$tag_include_selector" }
    if ($tag_exclude_selector){ $url = "$url&tag_exclude_selector=$tag_exclude_selector" }
    if ($tag_set_by){ $url = "$url&tag_set_by=$tag_set_by" }
    if ($tag_set_include){ $url = "$url&tag_set_include=$tag_set_include" }
    if ($tag_set_exclude){ $url = "$url&tag_set_exclude=$tag_set_exclude" }

        
        $resp = Invoke-WebPostRequest($url) 
        return [xml]$resp
    }
    End
    {
    }
}

<#
.Synopsis
   Invoke-LaunchCompliancePolicyReport
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-LaunchCompliancePolicyReport
{
  [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # echo request {true|false} default is false
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID Number
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$template_id,

         # Report Title
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$report_title,

        # pdf Password
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$pdf_password,

        # Reciepient Group
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$recipient_group,

        # Hide Header
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$hide_header,

        # Use Tags
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$use_tags,

        # Tags to Include Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_include_selector,
        
        # Tags to Exclude Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_exclude_selector,

        # Tags set by
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('id','name')]
        [string]$tag_set_by,

        
        # Tags set include
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_include,

        
        # Tags set exclude
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_exclude,

        #----------Compliancy Policy Report----------#

        # Output Format - mht is not valid for PCI Report
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('pdf', 'html', 'mht', 'xml', 'csv')]
        [string]$output_format,

        # Policy_id - 
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$policy_id,
         
         # Asset Group IDs 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$asset_group_ids,

        # IPs 
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$ips,

        # Instance_String
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$instance_string,

        # host_id
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$host_id
               
        )
        
    
    Begin
    {
        $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
        $url2 = "api/2.0/fo/report"
    }
    Process
    {
   #Remediation Report Specific
    $url = "$qualys_url/$url_2/?action=launch&template_id=$template_id&report_type=Policy&output_format=$output_format"
    if ($policy_id) {$url = "$url&policy_id=$policy_id"} 
    if ($asset_group_ids) {$url = "$url&asset_group_ids=$asset_group_ids"}
    if ($ips) {$url = "$url&ips=$ips"}
    if ($instance_string) {$url = "$url&instance_string=$instance_string"}
    if ($host_id) {$url = "$url&host_id=$host_id"}


    #neutral
    if ($echo_request){ $url = "$url&echo_request=1"}
    if ($template_id){ $url = "$url&template_id=$template_id" }
    if ($report_title){ $url = "$url&report_title=$report_title" }
    if ($pdf_password){ $url = "$url&pdf_password=$pdf_password" }
    if ($recipient_group){ $url = "$url&recipient_group=$recipient_group" }
    if ($hide_header){ $url = "$url&hide_header=1" }
    if ($use_tags){ $url = "$url&use_tags=1" }
    if ($tag_include_selector){ $url = "$url&tag_include_selector=$tag_include_selector" }
    if ($tag_exclude_selector){ $url = "$url&tag_exclude_selector=$tag_exclude_selector" }
    if ($tag_set_by){ $url = "$url&tag_set_by=$tag_set_by" }
    if ($tag_set_include){ $url = "$url&tag_set_include=$tag_set_include" }
    if ($tag_set_exclude){ $url = "$url&tag_set_exclude=$tag_set_exclude" }

        
        $resp = Invoke-WebPostRequest($url) 
        return [xml]$resp
    }
    End
    {
    }
}


<#
.Synopsis
   Invoke-QualysPatchReport
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Invoke-QualysPatchReport
{
  [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # echo request {true|false} default is false
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$echo_request,

        # Report ID Number
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$template_id,

         # Report Title
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$report_title,

        # pdf Password
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$pdf_password,

        # Reciepient Group
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$recipient_group,

        # Hide Header
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$hide_header,

        # Use Tags
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet($true)]
        [bool]$use_tags,

        # Tags to Include Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_include_selector,
        
        # Tags to Exclude Selector
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('all','any')]
        [string]$tag_exclude_selector,

        # Tags set by
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('id','name')]
        [string]$tag_set_by,

        
        # Tags set include
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_include,

        
        # Tags set exclude
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$tag_set_exclude,

        #----------Remediation Report----------#
             
        # Output Format -  (Required) One output format may be specified
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [ValidateSet('pdf', 'online', 'csv')]
        [string]$output_format,
        
        # IPs - IPs are used to specify hosts to include in the report
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$ips,
        
        # Asset Group IDs - asset_group_ids are used to specify hosts to include in the report
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$asset_group_id
        )

     Begin
    {
        $qualys_url = Get-Content -Path  "$env:USERPROFILE\documents\windowspowershell\modules\Qualys\qualys_url.txt"
        $url2 = "api/2.0/fo/report"
    }
    Process
    {
   #Remediation Report Specific
    $url = "$qualys_url/$url_2/?action=launch&template_id=$template_id&output_format=$output_format"
    if ($asset_group_ids) {$url = "$url&asset_group_ids=$asset_group_ids"}
    if ($ips) {$url = "$url&ips=$ips"}


    #neutral
    if ($echo_request){ $url = "$url&echo_request=1"}
    if ($template_id){ $url = "$url&template_id=$template_id" }
    if ($report_title){ $url = "$url&report_title=$report_title" }
    if ($pdf_password){ $url = "$url&pdf_password=$pdf_password" }
    if ($recipient_group){ $url = "$url&recipient_group=$recipient_group" }
    if ($hide_header){ $url = "$url&hide_header=1" }
    if ($use_tags){ $url = "$url&use_tags=1" }
    if ($tag_include_selector){ $url = "$url&tag_include_selector=$tag_include_selector" }
    if ($tag_exclude_selector){ $url = "$url&tag_exclude_selector=$tag_exclude_selector" }
    if ($tag_set_by){ $url = "$url&tag_set_by=$tag_set_by" }
    if ($tag_set_include){ $url = "$url&tag_set_include=$tag_set_include" }
    if ($tag_set_exclude){ $url = "$url&tag_set_exclude=$tag_set_exclude" }

        
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
