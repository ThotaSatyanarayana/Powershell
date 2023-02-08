# Connect to Azure
Connect-AzAccount


# Get the total number of resources in the subscription
$totalResources = (Get-AzResource).Count

# Get the number of untagged resources
$untaggedResources = (Get-AzResource | Where-Object {-not $_.Tags}).Count

# Calculate the percentage of untagged resources
$percentageUntagged = ($untaggedResources / $totalResources) * 100

# Display the result
Write-Output "Percentage of untagged resources: $percentageUntagged%"
