# Simple polling solution: move all files from C:\Temp1 to C:\Temp2 every 2 seconds

$source = "C:\Temp1"
$destination = "C:\Temp2"

while ($true) {
    # Get all files (non-recursive) in the source folder
    Get-ChildItem -Path $source -File | ForEach-Object {
        $sourceFile = $_.FullName
        $destFile = Join-Path $destination $_.Name
        try {
            Move-Item -Path $sourceFile -Destination $destFile -Force
            Write-Host "Moved $sourceFile to $destFile"
        }
        catch {
            Write-Host "Error moving ${sourceFile}: $_"
        }
    }
    Start-Sleep -Seconds 2
}
