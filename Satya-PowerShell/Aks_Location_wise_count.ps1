#Connect-AzAccount
$Aks = Get-AzAksCluster
$locations= $aks| Group-Object -Property Location |  Select-Object Name,count #| Out-File -FilePath C:\Users\koritala.vasanthi\Aks_Location_wise_count.csv

$locations

