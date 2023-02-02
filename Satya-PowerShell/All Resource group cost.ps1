$RGs = Get-AzResourceGroup
foreach($RG in $RGs)
{  
 $startDate = [datetime]::Today.AddDays(-7).ToString('MM/dd/yyy')
 $endDate = [datetime]::Today.ToString('MM/dd/yyy') 
   #$ResourceGroupName = get-azureRmResourcegroup 

   $resources = Get-AzureRmConsumptionUsageDetail -ResourceGroup $RG.ResourceGroupName -StartDate $startDate -EndDate $endDate 
   Write-Output ' Resourcegroupname:' $RG.ResourceGroupName  

foreach ($rg in $resources)    { 
        $total = $total + $rg.PretaxCost 
   } 
    Write-Output 'The total cost ' $total   
   $total = 0 
}

