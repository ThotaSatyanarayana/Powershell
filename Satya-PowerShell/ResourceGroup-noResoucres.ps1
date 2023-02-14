

# Login to your Azure account
Connect-AzAccount

# Get a list of all resource groups in the current subscription
$resourceGroups = Get-AzResourceGroup

# Loop through each resource group and check if it's empty
foreach ($resourceGroup in $resourceGroups) {
    $resources = Get-AzResource -ResourceGroupName $resourceGroup.ResourceGroupName
    if ($resources -eq $null) {
        Write-Output "Empty resource group: $($resourceGroup.ResourceGroupName)"
    }
}


#..............................


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
