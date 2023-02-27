$resourceGroups = Get-AzResourceGroup 
# Loop through each resource group and get Cosmos DB accounts
foreach ($resourceGroup in $resourceGroups) { 
   $accounts = Get-AzCosmosDBAccount -ResourceGroupName $resourceGroup.ResourceGroupName   
  # Loop through each account and group them by location 
   $accountGroups = $accounts | Group-Object -Property Location 
    # Display the number of accounts in each location 
   foreach ($group in $accountGroups) {    
    Write-Host "$($resourceGroup.ResourceGroupName) $($group.Name) $($group.Count)"    
   }
}