$usageDetails = Get-AzConsumptionUsageDetail #-StartTime "2022-01-01" -EndTime "2022-01-31"

# Group the usage details by service name and sum the costs

$serviceCosts = $usageDetails | Group-Object -Property ConsumedService | ForEach-Object { 
    [PSCustomObject]@{ 
       Service = $_.Name  
      Cost = ($_.Group | Measure-Object -Property PretaxCost -Sum).Sum 
   }
}
$serviceCosts | sort-object -property cost -descending