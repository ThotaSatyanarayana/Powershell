Connect-AzAccount

# Select the Azure subscription to use
$subscription = Get-AzSubscription 
Select-AzSubscription -SubscriptionId $subscription.SubscriptionId

# Get the cost information for the current subscription
$startDate = (Get-Date).AddDays(-7)
$endDate = (Get-Date)
$costs = Get-AzureRmConsumptionUsageDetail  -StartDate $startDate -EndDate $endDate 

# Group the cost information by service
$groupedCosts = $costs | Group-Object -Property ResourceName |
                 Select-Object -Property @{Label="Service";Expression={$_.Name}},
                 @{Label="Total Cost (USD)";Expression={($_.Group | Measure-Object -Property PreTaxCost -Sum).Sum}}

# Display the cost information
$groupedCosts | Sort-Object -Property "Total Cost (USD)" -Descending |
               Select-Object -First 10 
               
