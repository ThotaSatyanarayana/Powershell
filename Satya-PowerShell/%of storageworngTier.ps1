Connect-AzAccount

$Wrongtierlists =@()
# Get all storage accounts
$storageAccounts = Get-AzStorageAccount

# Define the desired tier
$desiredTier = "Hot"

# Calculate the total storage in all storage accounts
$totalStorage = 0
foreach ($storageAccount in $storageAccounts) {
  $totalStorage ++
}

# Calculate the storage in the wrong tier
$wrongTierStorage = 0
foreach ($storageAccount in $storageAccounts) {

  if ($storageAccount.AccessTier -ne $desiredTier) {
    $wrongTierStorage ++ #= $storageAccount.AccessTier

   $Wrongtierlist = [PSCustomObject]@{
            'StorageAccountName' = $storageAccount.StorageAccountName
            'Location' = $storageAccount.Location
            'ResourceGroupName' = $storageAccount.ResourceGroupName
            'CreationTime' = $storageAccount.CreationTime
            'AccessTier' =$storageAccount.AccessTier

      }
       $Wrongtierlists += $Wrongtierlist
   }
}

# Calculate the percentage of storage in the wrong tier
$percentWrongTier = ($wrongTierStorage / $totalStorage) * 100

# Output the result
Write-Output "Percentage of storage in the wrong tier: $percentWrongTier%"
 
$Wrongtierlists
