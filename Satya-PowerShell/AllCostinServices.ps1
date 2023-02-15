$startDate = [datetime]::Today.AddDays(-7).ToString('MM/dd/yyy')
 $endDate = [datetime]::Today.ToString('MM/dd/yyy') 

# Get the list of Azure services and their costs
Get-AzConsumptionUsageDetail `
  -StartDate $startDate `
  -EndDate $endDate `
  | Select-Object -Property UsageStart, InstanceName,ConsumedService , PretaxCost `
  | Sort-Object -Property UsageStart -Descending | ft
