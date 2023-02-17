

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
      if ( $Days -ge 1)
      {
        Write-Output "Instance $($instance.Name) in Resource Group $($instance.ResourceGroupName) has been idle for more than 30 days."
       }

         
  }
}














.........................

# Not Correct

# Connect to Azure
Connect-AzAccount

# Define the idle threshold (in days)
$idleThreshold = 30

# Get a list of all virtual machines in Azure
$vms = Get-AzVM

# Loop through each virtual machine
foreach ($vm in $vms) {
    # Get the current status of the virtual machine
    $status = $vm.PowerState

    # Get the last active time of the virtual machine
    $lastActive = Get-AzDiagnosticSetting -ResourceId $vm.Id | Select-Object -ExpandProperty StorageAccount

    # Calculate the time since the virtual machine was last active
    $idleTime = (Get-Date) - $lastActive

    # Check if the virtual machine has been idle for less than the threshold
    if ($status -eq "VM running" -and $idleTime.TotalDays -lt $idleThreshold) {
        # Output the virtual machine as idle
        Write-Output "Virtual machine '$($vm.Name)' is idle ($($idleTime.TotalDays) days)"
    }
}
