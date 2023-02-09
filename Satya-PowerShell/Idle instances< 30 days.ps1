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
