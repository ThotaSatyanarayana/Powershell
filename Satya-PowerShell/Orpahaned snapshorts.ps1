# Connect to Azure
Connect-AzAccount

# Get all snapshots
$snapshots = Get-AzSnapshot
$totalSnapshots = $snapshots.Count
$orphanedSnapshots = 0

# Iterate through each snapshot
foreach ($snapshot in $snapshots) {
  # Get the disk for the snapshot
  $disk = Get-AzDisk -ResourceId $snapshot.DiskId -ErrorAction SilentlyContinue

  # Check if the disk is null
  if (!$disk) {
    # The snapshot is orphaned
    $orphanedSnapshots++
  }
}

# Calculate the percentage of orphaned snapshots
$orphanedPercentage = [math]::Round(($orphanedSnapshots / $totalSnapshots) * 100, 2)

# Output the results
Write-Output "Total snapshots: $totalSnapshots"  "Orphaned snapshots: $orphanedSnapshots" "Percentage of orphaned snapshots: $orphanedPercentage%"

