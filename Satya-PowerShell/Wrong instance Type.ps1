# Connect to Azure
Connect-AzAccount

# Get the total number of virtual machine resources in the subscription
$totalVMs = (Get-AzVM).Count

# Get the number of virtual machines with an incorrect instance type
$incorrectInstanceTypeVMs = (Get-AzVM | Where-Object {$_.HardwareProfile.VmSize -ne "Standard_B1s"}).Count

# Calculate the percentage of virtual machines with incorrect instance type
$percentageIncorrectInstanceType = ($incorrectInstanceTypeVMs / $totalVMs) * 100

# Display the result
Write-Output "Percentage of virtual machines with incorrect instance type: $percentageIncorrectInstanceType%"
