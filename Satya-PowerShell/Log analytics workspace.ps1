
 # Log analytics workspace 
$loglists =@()
$Logs = Get-AzOperationalInsightsWorkspace
 
foreach($Log in $Logs)
{
    $loglist = [PSCustomObject]@{
      LogName = $Log.Name
      ResourceGroupName= $Log.ResourceGroupName
      Location = $Log.Location
      CustomerId = $Log.CustomerId
      CreatedDate = $Log.CreatedDate
   }
    $loglists += $loglist
 
}
$loglists | ft
