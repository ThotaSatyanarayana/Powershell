Connect-AzAccount
$services = Get-AzResource | Group-Object -Property ResourceType | Select-Object -Property Name, Count | Sort-Object -Property Count -Descending | Select-Object -First 10
$services

