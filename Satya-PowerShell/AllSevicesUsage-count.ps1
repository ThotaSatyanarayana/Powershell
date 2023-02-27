#Connect-AzAccount
$services = Get-AzResource | Group-Object -Property ResourceType|  Select-Object -Property Name, Count | Sort-Object -Property Count -Descending 
$services # out-file -FilePath C:\Users\koritala.vasanthi\Servicenames-count.csv