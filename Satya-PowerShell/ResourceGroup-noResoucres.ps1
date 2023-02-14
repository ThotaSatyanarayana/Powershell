

$resourceGroups = Get-AzResourceGroup
$Header = @("ResourceGroupName","Location")
$resourceinfo = @()
foreach ($resourceGroup in $resourceGroups) {
 $resources = Get-AzResource -ResourceGroupName $resourceGroup.ResourceGroupName
 $Row = [PSCustomObject] @{
    ResourceGroupName =$resourceGroup.ResourceGroupName
    Location = $resourceGroup.Location
}
    if ($resources.Count -eq 0) {
    
       #$resourceGroup.ResourceGroupName |ft
       $resourceinfo += $Row 
    }
}$resourceinfo
