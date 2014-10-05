Get-ChildItem -Path $PSScriptRoot\*.ps1 | Foreach-Object{ . $_.FullName }

#New-Alias Invoke-ManageScans Manage-QScans

Export-ModuleMember -Function * -Alias *