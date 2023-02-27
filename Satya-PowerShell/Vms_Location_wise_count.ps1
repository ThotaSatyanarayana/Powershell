Connect-AzAccount
$Vms=Get-AzVM
$locations= $Vms| Group-Object -Property Location |  Select-Object Name,count

$locations

 # | Out-File -FilePath C:\Users\koritala.vasanthi\VMs_Location_wise_count.csv

