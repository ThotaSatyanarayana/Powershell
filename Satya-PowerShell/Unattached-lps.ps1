$publicIps = Get-AzPublicIpAddress
$UnattachedInfo= @()
# Iterate through each public IP address
foreach ($publicIp in $publicIps) {
  # If the public IP address is not assigned to a network interface
  if (!$publicIp.IpConfiguration) {
    $Data = [PSCustomObject]@{
     ResourceName = $publicIp.Name
     resourceGroupName = $publicIp.ResourceGroupName
     publicIpAddress = $publicIp.IpAddress
}
$UnattachedInfo += $Data
    # Print the name and resource group of the public IP address
    #Write-Output "Unattached public IP address: $($publicIp.Name) in resource group $($publicIp.ResourceGroupName) with IP address $($publicIp.IpAddress)." | Out-File -FilePath  C:\Users\koritala.vasanthi\UnattachedIp.csv
  } }$UnattachedInfo | Out-File -FilePath C:\Users\koritala.vasanthi\UnattchedIP.csv
