$rgs = Get-AzResourceGroup
$output = @()
foreach ($rg in $rgs) {
    # Get the Owner(s) of the Resource Group
    $owners = Get-AzRoleAssignment `
        -Scope $rg.ResourceId `
        -RoleDefinitionName "Owner" `
        | Select-Object -ExpandProperty SignInName -Unique
    # Combine all the owners into a single string
    $ownersString = $owners -join ", " 
    $rgOwner = [PSCustomObject]@{
        "Resource Group Name" = $rg.ResourceGroupName
        "Owners" = $ownersString
    }   
    $output += $rgOwner
} 
$output | Export-Csv -Path "C:\Users\thota.satyanarayana\Satya\CRGOwnerlist.csv" -NoTypeInformation -Force  #| out-file -FliePath 