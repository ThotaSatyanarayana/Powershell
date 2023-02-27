
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
