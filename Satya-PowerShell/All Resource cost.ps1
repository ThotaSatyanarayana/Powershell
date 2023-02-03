$start = (Get-Date).AddDays(-7)
$end = Get-Date # Retrieve cost data from Azure Cost Management
$costData = Get-AzConsumptionUsageDetail  -StartDate 2022-01-27 -EndDate 2023-02-01 

# Group data by resource
$groupedData = $costData | Group-Object -Property InstanceName # Loop through each group and calculate the total cost for each resource

foreach ($group in $groupedData) {
  $resource = $group.Name
  $totalCost = ($group.Group | Measure-Object -Property PretaxCost -Sum).Sum
  Write-Output "$resource - $totalCost"
}


# Order By

$start = (Get-Date).AddDays(-7)
$end = Get-Date # Retrieve cost data fro m Azure Cost Management
$costData = Get-AzConsumptionUsageDetail -StartDate 2022-01-27 -EndDate 2023-02-01 # Group data by resource
$groupedData = $costData | Group-Object -Property InstanceName # Create an array to store resource cost data
$resourceCost = @() # Loop through each group and calculate the total cost for each resource
foreach ($group in $groupedData) {
  $resource = $group.Name
  $totalCost = ($group.Group | Measure-Object -Property PretaxCost -Sum).Sum
  $resourceCost += [PSCustomObject]@{
    Resource = $resource
    Cost = $totalCost
  }
} # Sort the resource cost data in descending order
$sortedCostData = $resourceCost | Sort-Object -Property Cost -Descending # Output the sorted cost data
foreach ($item in $sortedCostData) {
  Write-Output "$($item.Resource) - $($item.Cost)"
}



# using Export to csv file or txt or

$start = (Get-Date).AddDays(-7)
$end = Get-Date
$costData = Get-AzConsumptionUsageDetail -StartDate 2022-01-27 -EndDate 2023-02-01
$groupedData = $costData | Group-Object -Property InstanceName
$resourceCost = @()
foreach ($group in $groupedData) {
  $resource = $group.Name
  $totalCost = ($group.Group | Measure-Object -Property PretaxCost -Sum).Sum
  $resourceCost += [PSCustomObject]@{
    Resource = $resource
    Cost = $totalCost
  }
}
$sortedCostData = $resourceCost | Sort-Object -Property Cost -Descending
$output = ''
foreach ($item in $sortedCostData) {
  $output += "$($item.Resource) - $($item.Cost)" + [Environment]::NewLine
}
$output | Out-File -FilePath "CostData.txt"
