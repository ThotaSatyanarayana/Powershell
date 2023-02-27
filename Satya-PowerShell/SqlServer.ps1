Connect-AzAccount



        
$sqlServers = Get-AzSqlServer # Loop through SQL Servers and get all databases
foreach ($sqlServer in $sqlServers) {
    Write-Output "SQL Server: $($sqlServer.ServerName)"
    $databases = Get-AzSqlDatabase -ServerName $sqlServer.ServerName -ResourceGroupName $sqlServer.ResourceGroupName     # Display the list of databases
    foreach ($database in $databases) {
        Write-Output "    Database: $($database.DatabaseName)"
    }
}
....................

# Servernames and Dataase count

$sqlServers = Get-AzSqlServer # Loop through each SQL server and count the number of databases
$results = @()
foreach ($sqlServer in $sqlServers) {
    $databaseCount = (Get-AzSqlDatabase -ServerName $sqlServer.ServerName -ResourceGroupName $sqlServer.ResourceGroupName).Count
    $result = [PSCustomObject]@{
        ServerName = $sqlServer.ServerName
        DatabaseCount = $databaseCount
       # Location = $sqlServer.Location
    }
    $results += $result
}
$results
.............................

$sqlServers = Get-AzSqlServer # Loop through each SQL server and count the number of databases
$results = @()
foreach ($sqlServer in $sqlServers) {
   $databases = Get-AzSqlDatabase -ServerName $sqlServer.ServerName -ResourceGroupName $sqlServer.ResourceGroupName
   $place = $databases | Group-Object -Property Location  |  Select-Object Name,count
    $result = [PSCustomObject]@{
        ServerName = $sqlServer.ServerName
        DatabaseCount = $place
       # Location = $sqlServer.Location
    }
    $results += $result

}
 $results
..................

# SqlServer


        
$sqlServers = Get-AzSqlServer # Loop through SQL Servers and get all databases
foreach ($sqlServer in $sqlServers) {
    Write-Output "SQL Server: $($sqlServer.ServerName)"
   $databases = Get-AzSqlDatabase -ServerName $sqlServer.ServerName -ResourceGroupName $sqlServer.ResourceGroupName     # Display the list of databases
   $databases | Group-Object -Property Location |  Select-Object Name,count  # |  Out-File -FilePath  C:\Users\thota.satyanarayana\Documents\SqlServer1.csv
}



....................

#CosmosDmServer

Connect-AzAccount
$sqlServers = Get-AzCosmosDBService # Loop through SQL Servers and get all databases
foreach ($sqlServer in $sqlServers) {
    Write-Output "SQL Server: $($sqlServer.ServerName)"
    $databases = Get-AzSqlDatabase -ServerName $sqlServer.ServerName -ResourceGroupName $sqlServer.ResourceGroupName     # Display the list of databases
   $databases | Group-Object -Property Location |  Select-Object Name,count 
}


...............

Get-AzCosmosDBMongoDBDatabase

$Comsmos = Get-AzCosmosDBAccount

foreach ($Comsmo in $Comsmos) {
    
    $databases = Get-AzSqlDatabase -ServerName $sqlServer.ServerName -ResourceGroupName $sqlServer.ResourceGroupName     # Display the list of databases
   $databases | Group-Object -Property Location |  Select-Object Name,count 
}


Connect-AzAccount
$Rgs = Get-AzResourceGroup
foreach($Rg in $Rgs)
{

$Comsmos = Get-AzCosmosDBAccount -ResourceGroupName $Rg.ResourceGroupName
}
$Comsmos

................



..........................

