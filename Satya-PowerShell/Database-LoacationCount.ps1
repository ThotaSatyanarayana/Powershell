Connect-AzAccount 
# Get all SQL servers in the subscription
$servers = Get-AzSqlServer
 # Loop through each server and create a hashtable with the server name, location, and database count
$results = @()
foreach ($server in $servers) {  
  $result = @{ 
       "Location" = $server.Location  
      "DatabaseCount" = ($server | Get-AzSqlDatabase).Count 
      }  
  $results += New-Object PSObject -Property $result
} 
# Group the results by location and sum the database counts
$locationGroups = $results | Group-Object -Property Location | Select-Object Name, @{Name="DatabaseCount";Expression={$_.Group.DatabaseCount | Measure-Object -Sum | Select-Object -ExpandProperty Sum
}
}
 # Output the results to the console
foreach ($group in $locationGroups) {
    Write-Host "$($group.Name): $($group.DatabaseCount)"
} # Export the results to a CSV file

$locationGroups | ft