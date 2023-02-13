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


................................
                           # Its Correct
$orphanedStorageAccounts = @()
# Get all storage accounts in the subscription
$storageAccounts = Get-AzStorageAccount
# Loop through each storage account
foreach ($storageAccount in $storageAccounts) {
    $resources = Get-AzResource -ResourceId $storageAccount.Id 
    # Check if the storage account has a resource group
    if ($resources.ResourceGroupName -ne $null) {
        $orphanedStorageAccount = [PSCustomObject]@{
            'StorageAccountName' = $storageAccount.StorageAccountName
            'Location' = $storageAccount.Location
            'ResourceGroupName' = $storageAccount.ResourceGroupName
            'CreationTime' = $storageAccount.CreationTime

        } 
        $orphanedStorageAccounts += $orphanedStorageAccount 
    }
      
}
# Output the list of orphaned storage accounts
$orphanedStorageAccounts |  Out-File orphanstorage.txt

..................................................
 # percentage of Orphaned storage account
 
$orphanedStorageAccounts = @()
# Get all storage accounts in the subscription
$storageAccounts = Get-AzStorageAccount
$totalStorageaccounts = $storageAccounts.count
# Loop through each storage account
$totalOrphaneAccounts=0
foreach ($storageAccount in $storageAccounts) {
    $resources = Get-AzResource -ResourceId $storageAccount.Id 

    # Check if the storage account has a resource group
    
 
    if ($resources.ResourceGroupName -eq $null) {
        $totalOrphaneAccounts ++
        $orphanedStorageAccount = [PSCustomObject]@{
            'StorageAccountName' = $storageAccount.StorageAccountName
            'Location' = $storageAccount.Location
            'ResourceGroupName' = $storageAccount.ResourceGroupName
            'CreationTime' = $storageAccount.CreationTime

        } 
        
        $orphanedStorageAccounts += $orphanedStorageAccount 
    }
      
}
$orphanedPercentage = [math]::Round(($totalOrphaneAccounts / $totalStorageaccounts) * 100, 2) # Output the results
# Output the list of orphaned storage accounts
Write-host "Total Storageaccounts: $totalStorageaccounts  and  Totalorphanedastorages: $totalOrphaneAccounts  PercentageofOrphaned:$orphanedPercentage"


$orphanedStorageAccounts |  Out-File orphanstorage7.txt
.............................


              # Another Method.........

$storageAccounts = Get-AzStorageAccount
$resources = Get-AzResource | Where-Object { $_.Type -eq 'Microsoft.Storage/storageAccounts' }
$usedStorageAccounts = $resources | Select-Object -ExpandProperty Name
$orphanedStorageAccounts = $storageAccounts | Where-Object { $_.Name -notin $usedStorageAccounts }
$orphanedStorageAccounts | Select-Object -Property StorageAccountName,ResourceGroupName,PrimaryLocation,CreationTime 

....................
$orphanedStorageAccounts = @()
# Get all storage accounts in the subscription
$storageAccounts = Get-AzStorageAccount
# Loop through each storage account
foreach ($storageAccount in $storageAccounts) {
    $resources = Get-AzResource -ResourceId $storageAccount.Id 
    # Check if the storage account has a resource group
    if ($resources.ResourceGroupName -ne $null) {
        $orphanedStorageAccount = [PSCustomObject]@{
            'StorageAccountName' = $storageAccount.StorageAccountName
            'Location' = $storageAccount.Location
        }
        $orphanedStorageAccounts += $orphanedStorageAccount
    }
}


......................




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



              # Subscription to subscription move

# Connect to Azure
Connect-AzAccount

# Get all storage accounts
$storageAccounts = Get-AzStorageAccount

# Loop through each storage account
foreach ($storageAccount in $storageAccounts) {

    # Get the subscription id of the storage account
    # $subscriptionId = $storageAccount.Context.Subscription.Id
     $subscriptionId =(Get-AzContext).Subscription.Id
	


    # Check if the subscription exists
    $subscription = Get-AzSubscription -SubscriptionId $subscriptionId -ErrorAction SilentlyContinue
    if (!$subscriptionId) {

        # If the subscription does not exist, the storage account is considered orphaned
        Write-Output "Orphaned storage account found: $($storageAccount.StorageAccountName)"
    }
}

