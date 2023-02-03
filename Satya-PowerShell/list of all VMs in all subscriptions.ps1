
$subs = Get-AzureRmSubscription

$vmobjs = @()

foreach ($sub in $subs)
{

Write-Host "Processing subscription $($sub.Name)"
try
{
Select-AzureRmSubscription -SubscriptionId $sub.SubscriptionId -ErrorAction Continue

$vms = Get-AzureRmVm

foreach ($vm in $vms)
{
write-host $vm.Name , $vm.ResourceGroupName , $vm.HardwareProfile.VmSize , $vm.OsType , $vm.ProvisioningState , $vm.Location , $vm.StorageProfile.OsDisk.Name
$VMReport += New-Object psobject -Property @{
"SubName" = $sub.Name
"VMName" = $vm.Name
"VMSize" = $vm.HardwareProfile.VmSize
"VMOSType" = $vm.OsType
"VMProvisioningState" = $vm.ProvisioningState
"VMLocation" = $vm.Location
"VMOSDisk" = $vm.StorageProfile.OsDisk.Name
}
}
}
catch
{
Write-Host $error[0]
}
}
