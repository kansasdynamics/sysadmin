# Define the paths to your tab-delimited text files
$txt1Path = "C:\path\to\file1.txt"
$txt2Path = "C:\path\to\file2.txt"
$outputPath = "C:\path\to\output.txt"

# Import the tab-delimited text files
$txt1 = Import-Csv -Path $txt1Path -Delimiter "`t"
$txt2 = Import-Csv -Path $txt2Path -Delimiter "`t"

# Function to convert rows to a string for comparison
function ConvertRowToString {
    param($row)
    return ($row.PSObject.Properties | ForEach-Object { $_.Value }) -join ','
}

# Convert both text files to sets of string rows for comparison
$txt1Rows = $txt1 | ForEach-Object { ConvertRowToString $_ }
$txt2Rows = $txt2 | ForEach-Object { ConvertRowToString $_ }

# Find rows that are only in txt1 or txt2
$diff1 = $txt1 | Where-Object { (ConvertRowToString $_) -notin $txt2Rows }
$diff2 = $txt2 | Where-Object { (ConvertRowToString $_) -notin $txt1Rows }

# Combine the unique rows
$uniqueRows = $diff1 + $diff2

# Export the unique rows to a new tab-delimited text file
$uniqueRows | Export-Csv -Path $outputPath -Delimiter "`t" -NoTypeInformation

Write-Host "Comparison complete. Unique rows exported to $outputPath."
