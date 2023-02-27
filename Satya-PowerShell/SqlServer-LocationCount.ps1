 # Get all SQL servers
$servers = Get-AzSqlServer
 # Loop through each server and group them by location
$serverGroups = $servers | Group-Object -Property Location 
# Display the number of servers in each location
foreach ($group in $serverGroups) {  
  Write-Host "$($group.Name) $($group.Count)"}




..................

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
 $results | Out-File -FilePath  C:\Users\thota.satyanarayana\Documents\SqlServer-LocationzCount.csv

 ..............

 $servers = Get-AzSqlServer 
 # Loop through each server and display its name, location, and number of databases
 foreach ($server in $servers) { 
    $location = $server.Location  
   $databaseCount = ($server | Get-AzSqlDatabase).Count   
  Write-Host "$($server.ServerName) : $location : $databaseCount"
  }

