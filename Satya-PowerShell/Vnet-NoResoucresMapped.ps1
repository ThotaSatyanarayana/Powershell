
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
