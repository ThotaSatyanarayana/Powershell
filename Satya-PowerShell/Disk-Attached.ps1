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

#Totacl count Disk and GB to TB Convert


$TotalSize = 0
$UnallocatedDisks =@()
$disks = Get-AzDisk

# Loop through the disks and filter the unallocated disks
foreach ($disk in $disks) {
    $diskName = $disk.Name
$resourceGroupName = $disk.ResourceGroupName     
$disk = Get-AzDisk -Name $disk.Name -ResourceGroupName $resourceGroupName

# Check if the disk is allocated
if ($disk.DiskState -eq 'Reserved'  ) {
  #  Write-Output "Disk $diskName in resource group $resourceGroupName is currently allocated to a virtual machine"
  $UnallocatedDisk = [PSCustomObject]@{
           
           'DiskSizeGB' = $disk.DiskSizeGB
           
       }
 $TotalSize += $disk.DiskSizeGB 
   $UnallocatedDisks += $UnallocatedDisk  
  }
}
 $AllDisks =$TotalSize  / 1024
$Totalcountodsik = $UnallocatedDisks.count
Write-host "All Unattached disk Count: $Totalcountodsik  and Size: $AllDisks TB"
