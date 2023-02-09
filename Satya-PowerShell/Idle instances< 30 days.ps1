# Login to Azure
Connect-AzAccount

# Set the subscription that contains the snapshots
Set-AzContext -SubscriptionId "a8cddc3a-fd61-452d-8abe-f7b44b38f5fd"

# Get the list of snapshots in the subscription
$snapshots = Get-AzSnapshot

# Loop through each snapshot and calculate its age
foreach ($snapshot in $snapshots) {
    # Calculate the age of the snapshot
    $age = [int]((Get-Date) - $snapshot.TimeCreated ).TotalDays

    # Check if the snapshot is older than 30 days
    if ($age -lt 30) {
        Write-Output "Snapshot $($snapshot.Name) in resource group $($snapshot.ResourceGroupName) is Young than 30 days."
    }
    else
   {
      Write-Output "Plz check once conditaion days"
   }


}
