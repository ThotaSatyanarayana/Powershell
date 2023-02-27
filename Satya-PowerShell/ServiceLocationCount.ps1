
$costByService | Select-Object Service, Cost | Format-Table -AutoSize
 $resources = Get-AzResource
$servicesByRegion = $resources | Group-Object -Property Location -AsHashTable
 $report = @()
foreach ($region in $servicesByRegion.Keys) {
    $services = $servicesByRegion[$region] | Select-Object -ExpandProperty ResourceType | Sort-Object -Unique
    $serviceCount = $services.Count
    $report += [PSCustomObject]@{
        Location = $region
        Count = $serviceCount
    }
} $report

 







$usageDetails = Get-AzConsumptionUsageDetail #-StartTime "2022-01-01" -EndTime "2022-01-31"

# Group the usage details by service name and sum the costs

$serviceCosts = $usageDetails | Group-Object -Property InstanceLocation | Select-Object Name,count
	
$serviceCosts
