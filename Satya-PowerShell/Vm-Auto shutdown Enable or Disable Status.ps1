$RGs = Get-AzResourceGroup
 foreach($RG in $RGs)
 {
    (Get-AzResource -ResourceGroupName $RG.ResourceGroupName -ResourceType Microsoft.DevTestLab/schedules -Expandproperties).Properties | Select-Object -Property targetResourceId, status,dailyRecurrence | ft
