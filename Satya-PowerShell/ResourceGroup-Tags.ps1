  Connect-azaccount

$Rgs= Get-azResourceGroup
$Rows=@()
foreach($Rg in $Rgs)
{
 $Row =[PSCustomObject]@{
ResourceGroupName=$Rg.ResourceGroupName
Tags=$Rg.Tags
}
$Rows += $Row
}
$Rows | ft


$Rows.count
