connect-AzAccount


$RGs = Get-AzureRMResourceGroup
foreach($RG in $RGs)
  {
    (Get-AzureRmResource -ResourceGroupName $RG.ResourceGroupName  -ResourceType Microsoft.DevTestLab/schedules -Expandproperties).Properties | Select-Object -Property  targetResourceId, status, dailyRecurrence | ft


}