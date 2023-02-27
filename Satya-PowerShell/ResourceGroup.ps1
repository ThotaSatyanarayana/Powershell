$RGs = Get-AzResourceGroup
$output = ""
foreach($RG in $RGs){ 
$resources = Get-AzConsumptionUsageDetail -ResourceGroup $RG.ResourceGroupName # -StartDate (get-date).AddDays(-7) -EndDate (get-date)
$output += "$($RG.ResourceGroupName)" + [Environment]::NewLine

foreach ($rg in $resources){
$total = $total + $rg.PretaxCost
}
$output += " $total" + [Environment]::NewLine



$total = 0
}
$output