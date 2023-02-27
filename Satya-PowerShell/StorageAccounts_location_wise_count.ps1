#Connect-AzAccount
$SAs=Get-AzStorageAccount

$locations= $SAs| Group-Object -Property Location |  Select-Object Name,count 
$locations
#| Out-File -FilePath C:\Users\koritala.vasanthi\StorageAccounts_Location_wise_count.csv

