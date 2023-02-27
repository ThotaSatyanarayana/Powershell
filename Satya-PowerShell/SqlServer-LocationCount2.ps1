Connect-AzAccount

$results =@()
$servers = Get-AzSqlServer
 # Loop through each server and group them by location
$serverGroups = $servers | Group-Object -Property Location 
# Display the number of servers in each location
foreach ($group in $serverGroups) { 
    $result = [PSCustomObject]@{ 
      Location = $group.Name 
      Count = $group.Count 
      } 
     $results +=$result  
 }
$results | ft