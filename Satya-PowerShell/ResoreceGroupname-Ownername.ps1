  Connect-AzAccount

$Rgs = Get-AzResourceGroup
$roles=Get-AzRoleAssignment
$RgInfo = @()
foreach($rg in $Rgs) {
foreach($roles in $roles){
    $Owner = Get-AzRoleAssignment -ResourceGroupName $rg.ResourceGroupName -RoleDefinitionName "Owner" | Select-Object -ExpandProperty DisplayName # or SignInName
    $Row = [PSCustomObject] @{
        ResourceGroupName = $rg.ResourceGroupName
       # Location = $rg.Location
        #ProvisioningState = $rg.ProvisioningState
        Tags = $rg.Tags
        Owner = $Owner
        }
    }
    $RgInfo += $Row
}
$RgInfo | ft