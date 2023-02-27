
$servers = Get-AzSqlServer
 # Group the servers by location and get the count for each location
$locations = $servers | Group-Object -Property Location | Select-Object Name, Count 
# Output the results with headings
Write-Output "Location`tServer Count"$locations | Out-File -FilePath C:\Users\thota.satyanarayana\Documents