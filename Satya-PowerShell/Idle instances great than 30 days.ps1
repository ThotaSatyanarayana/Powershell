# Get the Azure context
Connect-AzAccount

# Get the list of all instances in the subscription
$instances = Get-AzVM

# Loop through the instances and check if they have been idle for the last 30 days
foreach ($instance in $instances) {
    # Get the status of the instance
    $status = (Get-AzVM -ResourceGroupName $instance.ResourceGroupName -Name $instance.Name -Status).Statuses

    # Check if the instance is running and has been idle for the last 30 days
    if ($status.Code -eq "PowerState/deallocated" -and $status[1].DisplayStatus -eq "VM deallocated") {
        $lastActivityTime = $status[0].Time
        $Days = ((Get-date) - $lastActivityTime).Days
     #$Days
      if ( $Days -ge 30)
      {
        Write-Output "Instance $($instance.Name) in Resource Group $($instance.ResourceGroupName) has been idle for more than 30 days."
       }

         
  }
}
