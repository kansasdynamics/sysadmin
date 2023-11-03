# Import the required module
Import-Module SqlServer

# Database connection parameters
$serverName = "COMPUTERNAME\SQLEXPRESS"
$databaseName = "Database_Name"
$viewName = "View_Name"

# Variables for filename construction
$currentDate = Get-Date -Format "MMddyyyy"
$baseCsvPath = "C:\Database_CSV_Backups\View_Name"
$exportCsvPath = "$baseCsvPath-$currentDate.csv"

# Query the view
$query = "SELECT * FROM [$viewName]"

# Execute the SQL command, convert to CSV format, remove quotes, and save to the file
Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -Query $query | ConvertTo-Csv -NoTypeInformation -Delimiter "|" | Select-Object -Skip 1 | ForEach-Object { $_ -replace '"', '' } | Set-Content -Path $exportCsvPath

Write-Output "Exported the view to $exportCsvPath"
