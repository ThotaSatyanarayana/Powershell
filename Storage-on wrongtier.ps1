Connect-AzAccount

# Get all storage accounts
$storageAccounts = Get-AzStorageAccount

# Define the desired tier
$desiredTier = "Cool"

# Calculate the total storage in all storage accounts
#$totalStorage = 0
foreach ($storageAccount in $storageAccounts) {
  $totalStorage += ($storageAccount.AccessTier).Count
}

# Calculate the storage in the wrong tier
#$wrongTierStorage = 0
foreach ($storageAccount in $storageAccounts) {
  if ($storageAccount.AccessTier -ne $desiredTier) {
    $wrongTierStorage += ($storageAccount.AccessTier).Count
  }
}

# Calculate the percentage of storage in the wrong tier
$percentWrongTier = ($wrongTierStorage / $totalStorage) * 100

# Output the result
Write-Output "Percentage of storage in the wrong tier: $percentWrongTier%"
