# Define the directory path
$directoryPath = "C:\Path\To\XML\Files"

# Output CSV path
$outputCsv = "C:\Path\To\Output\BuyersOrderNumbers.csv"

# Create an empty array to store the results
$buyersOrderNumbers = @()

# Loop through all XML files in the directory
Get-ChildItem -Path $directoryPath -Filter *.xml | ForEach-Object {
    $xmlFile = $_.FullName
    
    # Load the XML content
    try {
        [xml]$xmlContent = Get-Content -Path $xmlFile
        
        # Extract the value of <BuyersOrderNumber>
        $buyersOrderNumber = $xmlContent.SelectSingleNode("//BuyersOrderNumber").InnerText
        
        # Output the value
        Write-Output "Buyers Order Number: $buyersOrderNumber from file: $($_.Name)"
        
        # Store the result in the array
        $buyersOrderNumbers += [pscustomobject]@{
            FileName = $_.Name
            BuyersOrderNumber = $buyersOrderNumber
        }
    }
    catch {
        Write-Output "Failed to read or parse $($_.Name)"
    }
}

# Export results to CSV
$buyersOrderNumbers | Export-Csv -Path $outputCsv -NoTypeInformation

Write-Output "Results exported to $outputCsv"
