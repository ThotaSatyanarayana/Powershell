$Subscriptions = Get-AzureRmSubscription 
$Report = ForEach ($Subscription in $Subscriptions) {
$SubscriptionName = $Subscription.Name
Set-AzureRmContext -SubscriptionName "$SubscriptionName" | Out-Null
$RGs = Get-AzureRMResourceGroup
foreach ($RG in $RGs) {
$VMs = Get-AzureRmVM -ResourceGroupName $RG.ResourceGroupName
foreach ($VM in $VMs) {
# VM Status (running/deallocated/stopped)
$VMDetail = Get-AzureRmVM -ResourceGroupName $RG.ResourceGroupName -Name $VM.Name -Status
$VMStatusDetail = $VMDetail.Statuses.DisplayStatus -match "^VM .*$"
New-Object psobject -Property @{
"SubscriptionName" = $SubscriptionName
"VMName" = $VM.Name
"VMStatus" = "$VMStatusDetail"
"OSType" = $VM.StorageProfile.OSDisk.OSType
"OSVersion" = $Vm.StorageProfile.ImageReference.Sku
"ResourceGroup" = $RG.ResourceGroupName
"Location" = $VM.Location
}
}
}
}




$Report | Export-Csv "c:\users\$env:username\documents\Azure_VMs_Status.csv" -Force -NoTypeInformation

