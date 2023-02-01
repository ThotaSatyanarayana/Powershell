$startDate = [datetime]::Today.AddDays(-7).ToString('MM/dd/yyy')

$endDate = [datetime]::Today.ToString('MM/dd/yyy')

$resources = Get-AzureRmConsumptionUsageDetail -ResourceGroup ramya -StartDate $startDate -EndDate $endDate

$total 
foreach ($rg in $resources)
{
$total = $total + $rg.PretaxCost

}


Write-Output 'The total cost ' $total 
$total = 0
