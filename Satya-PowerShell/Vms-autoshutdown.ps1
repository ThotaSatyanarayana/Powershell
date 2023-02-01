
Connect-AzAccount

Write-Host "Autoshutdown no.of Virtual-Machines"



$vms = Get-AzureRmvm

foreach ($vm in $vms)
{
$vm.Name
$vm.ResourceGroupName 
$shutdown_time = "1900"
$shutdown_timezone = "India Standard Time"

$properties = @{
    "status" = "Enabled";
    "taskType" = "ComputeVmShutdownTask";
    "dailyRecurrence" = @{"time" = $shutdown_time };
    "timeZoneId" = $shutdown_timezone;
    "notificationSettings" = @{
        "status" = "Disabled";
        "timeInMinutes" = 30
    }
    "targetResourceId" = (Get-AzureRmVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name).Id

 }

New-AzureRmResource -ResourceId ("/subscriptions/{0}/resourceGroups/{1}/providers/microsoft.devtestlab/schedules/shutdown-computevm-{2}" -f (Get-AzureRmContext).Subscription.Id, $vm.ResourceGroupName, $vm.Name) -Location (Get-AzureRmVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name).Location -Properties $properties -Force
}