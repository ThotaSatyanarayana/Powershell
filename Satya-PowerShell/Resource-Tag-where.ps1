
$RgInfo=@()
$resources = Get-AzResource -Tag @{ environment = "production" }

foreach ($resource in $resources) {
  $Row = [PSCustomObject] @{
    ResourceName = $resource.name
    Tags = $resource.Tags
  }
  $RgInfo += $Row
  
}
$RgInfo.count
