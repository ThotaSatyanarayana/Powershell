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

# Totalcost BY Month

$orphanedSnapshotlists =@() # Get all orphaned snapshots
$orphanedSnapshots = Get-AzSnapshot | Where-Object {$_.ManagedBy -eq $null} # Initialize total cost variable
$totalCost = 0 # Iterate over all orphaned snapshots
foreach ($snapshot in $orphanedSnapshots) {     # Get the snapshot creation time
    $snapshotCreateTime = $snapshot.TimeCreated     # Get the snapshot size
    $snapshotSize = $snapshot.DiskSizeGB     # Calculate the number of days since the snapshot was created
    $daysSinceCreation = ((get-Date) - $snapshot.TimeCreated).Days     # Calculate the cost of the snapshot
    $snapshotCost = $snapshotSize * 0.05 * $daysSinceCreation     # Add the snapshot cost to the total cost
    $totalCost += $snapshotCost 
  $orphanedSnapshotlist = [PSCustomObject]@{
SnapshotName =$snapshot.Name
  SnapshotSize = $snapshotSize
  TotalCost = $totalCost      }
$orphanedSnapshotlists += $orphanedSnapshotlist }
$orphanedSnapshotlists


# Totalcost By Days

$orphanedSnapshotlists =@() # Get all orphaned snapshots
$orphanedSnapshots = Get-AzSnapshot | Where-Object {$_.ManagedBy -eq $null} # Initialize total cost variable
$totalCost = 0 # Iterate over all orphaned snapshots
foreach ($snapshot in $orphanedSnapshots) {     # Get the snapshot creation time
    $snapshotCreateTime = $snapshot.TimeCreated     # Get the snapshot size
    $snapshotSize = $snapshot.DiskSizeGB     # Calculate the number of days since the snapshot was created
    $daysSinceCreation = ((get-Date) - $snapshot.TimeCreated).Days     # Calculate the cost of the snapshot
    $snapshotCost = $snapshotSize * 0.00164 * $daysSinceCreation     # Add the snapshot cost to the total cost
    $totalCost += $snapshotCost 
  $orphanedSnapshotlist = [PSCustomObject]@{
SnapshotName =$snapshot.Name
  SnapshotSize = $snapshotSize
  TotalCost = $totalCost      }
$orphanedSnapshotlists += $orphanedSnapshotlist }
$orphanedSnapshotlists
