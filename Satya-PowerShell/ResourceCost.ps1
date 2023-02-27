Connect-AzAccount

$Rows =@()
#$start = (Get-Date).AddDays(-30)
#$end = Get-Date # Retrieve cost data from Azure Cost Management
$costData = Get-AzConsumptionUsageDetail  #-StartDate $start -EndDate $end 

# Group data by resource
$groupedData = $costData  | Group-Object -Property InstanceName # Loop through each group and calculate the total cost for each resource

foreach ($group in $groupedData) {

  $resource = $group.Name
  $totalCost = ($group.Group | Measure-Object -Property PretaxCost -Sum).Sum

  $Row = [PSCustomObject] @{  
    InstanceName =$resource 
    Cost= $totalCost
   }
   $Rows +=$Row
   }

 # Write-Output "$resource - $totalC
$Rows  | Sort-Object -Property cost -Descending

$Rows.Count

$sa=Get-azResource
$sa.count
