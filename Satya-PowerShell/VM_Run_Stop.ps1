
Connect-AzureRmAccount

 Get-AzureRmVm | Get-AzureRmVm -Status | select ResourceGroupName, Name,@{n="Provisioned Time"; e={$_.Statuses[0].Time}}, @{n="Provisioned Status"; e={$_.Statuses[0].DisplayStatus}}, @{n="Running Status"; e={$_.Statuses[1].DisplayStatus}} | ft 



#  Only Running

 Get-AzureRmVm | Get-AzureRmVm -Status | where-Object {$_.Statuses[1].DisplayStatus -eq "VM running" } | select ResourceGroupName, Name,@{n='OSType';e={$_.osType[0].DisplayStatus}},@{n="Provisioned Time"; e={$_.Statuses[0].Time}}, @{n="Provisioned Status"; e={$_.Statuses[0].DisplayStatus}}, @{n="Running Status"; e={$_.Statuses[1].DisplayStatus}} | ft 

# Only VM deallocated 

Get-AzureRmVm | Get-AzureRmVm -Status | where-Object {$_.Statuses[1].DisplayStatus -eq "VM deallocated" } | select ResourceGroupName, Name,@{n='OSType';e={$_.osType[0].DisplayStatus}},@{n="Provisioned Time"; e={$_.Statuses[0].Time}}, @{n="Provisioned Status"; e={$_.Statuses[0].DisplayStatus}}, @{n="Running Status"; e={$_.Statuses[1].DisplayStatus}} | ft
