
# Connect to your Azure account
Connect-AzAccount

$vnets = Get-AzVirtualNetwork

# Loop through each virtual network to check if it has any resources
$empty_vnets = @()
foreach ($vnet in $vnets) {
    $resources = Get-AzResource -ResourceGroupName $vnet.ResourceGroupName
    if ($resources.Count -eq 1 -and $resources[0].ResourceType -eq "Microsoft.Network/virtualNetworks") {
        # If there is only one resource and it is the virtual network itself, add it to the list of empty virtual networks
        $empty_vnet = [PSCustomObject]@{
            'StorageAccountName' = $vnet.Name
            'Location' = $vnet.Location
             'ResourceGroupName'= $vnet.ResourceGroupName
      }

        $empty_vnets += $empty_vnet
    }
}

# Display the list of empty virtual networks
$empty_vnets







...............................

# Not Correct

# Get a list of all virtual networks in the current subscription
$virtualNetworks = Get-AzVirtualNetwork

# Loop through each virtual network and check if it has any resources mapped to it
foreach ($virtualNetwork in $virtualNetworks) {
    $subnetCount = @(Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $virtualNetwork).Count
    $nicCount = @(Get-AzNetworkInterface | Where-Object { $_.IpConfigurations.Subnet.Id -eq "/subscriptions/$($virtualNetwork.Id.Split('/')[2])/resourceGroups/$($virtualNetwork.ResourceGroupName)/providers/Microsoft.Network/virtualNetworks/$($virtualNetwork.Name)/subnets/default" }).Count
   
 if ($subnetCount -ne $nicCount) {
        Write-Output "Virtual network with no resources mapped: $($virtualNetwork.Name)"
    }
}
