Connect-azaccount




$Rgs = Get-azResourceGroup

$RgInfo = @()
foreach($rg in $Rgs) {
$resources = Get-AzResource -ResourceGroupName $rg.ResourceGroupName

foreach($resource in $resources)
{

  $Row = [PSCustomObject] @{
    ResourceName = $resource.name
    Tags = $resource.Tags
  }
  $RgInfo += $Row
  }
}
$RgInfo