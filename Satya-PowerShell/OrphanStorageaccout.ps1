# Get all storage accounts
$storageAccounts = Get-AzStorageAccount
$totalAccounts = $storageAccounts.Count
$orphanedAccounts = 0 # Iterate through each storage account
foreach ($storageAccount in $storageAccounts) {
  # Get the resource group for the storage account
  $resourceGroup = Get-AzResource -ResourceId $storageAccount.Id -ErrorAction SilentlyContinue   # Check if the resource group is null
  if (!$resourceGroup) {
    # The storage account is orphaned
    $orphanedAccounts++
  }
} # Calculate the percentage of orphaned storage accounts
$orphanedPercentage = [math]::Round(($orphanedAccounts / $totalAccounts) * 100, 2) # Output the results

# $output += Write-Output "Total storage accounts: $totalAccounts" + [Environment]::NewLine
# $output += Write-Output "Orphaned storage accounts: $orphanedAccounts" + [Environment]::NewLine
# $output += Write-Output "Percentage of orphaned storage accounts: $orphanedPercentage%" + [Environment]::NewLine


Write-Output "Total storage accounts: $totalAccounts" "Orphaned storage accounts: $orphanedAccounts" "Percentage of orphaned storage accounts: $orphanedPercentage%"  | Out-File orphan1.txt




# Another Method.........

$storageAccounts = Get-AzStorageAccount
$resources = Get-AzResource | Where-Object { $_.Type -eq 'Microsoft.Storage/storageAccounts' }
$usedStorageAccounts = $resources | Select-Object -ExpandProperty Name
$orphanedStorageAccounts = $storageAccounts | Where-Object { $_.Name -notin $usedStorageAccounts }
$orphanedStorageAccounts | Select-Object -Property StorageAccountName,ResourceGroupName,PrimaryLocation,CreationTime 






#percentage orphan

$storageAccounts = Get-AzStorageAccount
$resources = Get-AzResource | Where-Object { $_.Type -eq 'Microsoft.Storage/storageAccounts' }
$usedStorageAccounts = $resources | Select-Object -ExpandProperty Name
$orphanedStorageAccounts = $storageAccounts | Where-Object { $_.StorageAccountName -notin $usedStorageAccounts }
$totalStorageAccounts = $storageAccounts.Count
$totalOrphanedStorageAccounts = $orphanedStorageAccounts.Count
$percentageOrphanedStorageAccounts = ($totalOrphanedStorageAccounts / $totalStorageAccounts) * 100
$percentageOrphanedStorageAccounts
$orphanedStorageAccounts | Select-Object -Property StorageAccountName,ResourceGroupName,PrimaryLocation,CreationTime 
