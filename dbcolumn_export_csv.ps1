# Update the query below with your column and database table
$Query = "SELECT [COLUMN_NAME] FROM [DATABASE].[SCHEMA].[TABLE]"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
# Uncomment one of the lines below depending on authentication method 
# $SqlConnection.ConnectionString = "Server=DB_SERVER_NAME;Database=DB_DATABASE_NAME;Integrated Security=True"
# $SqlConnection.ConnectionString = "Server=DB_SERVER_NAME;Database=DB_DATABASE_NAME;User=DB_USERNAME;Password=DB_PASSWORD"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $Query
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet

try {
    $SqlAdapter.Fill($DataSet)
} catch {
    throw "Error executing SQL query: $_"
} finally {
    $SqlConnection.Close()
}

if ($DataSet.Tables.Count -gt 0) {
    $data = $DataSet.Tables[0].Rows | ForEach-Object { $_.Username }
    # Generate a timestamp
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    # Create a filename with the timestamp
    # Update the directory path to your chosen location
    $filename = "C:\Sample\users_$timestamp.csv"
    $data | Out-File -FilePath $filename
    Write-Host "Data exported to $filename"
} else {
    Write-Host "No data retrieved from the database."
}
