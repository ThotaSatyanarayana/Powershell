# Connect to Azure
Connect-AzAccount
$UnallocatedDisks =@()
$disks = Get-AzDisk

# Loop through the disks and filter the unallocated disks
foreach ($disk in $disks) {
    $diskName = $disk.Name
$resourceGroupName = $disk.ResourceGroupName     
$disk = Get-AzDisk -Name $disk.Name -ResourceGroupName $resourceGroupName

# Check if the disk is allocated
if ($disk.DiskState -eq 'Attached' -or $disk.DiskState -eq 'Reserved' ) {
  #  Write-Output "Disk $diskName in resource group $resourceGroupName is currently allocated to a virtual machine"
  $UnallocatedDisk = [PSCustomObject]@{
            'DiskName' = $disk.Name
            'Location' = $disk.Location
             'ResourceGroupName'= $disk.ResourceGroupName
       }
   $UnallocatedDisks += $UnallocatedDisk
  
}
 # else {
  #  Write-Output "Disk $diskName in resource group $resourceGroupName is currently unallocated"
  #}

}
$UnallocatedDisks
