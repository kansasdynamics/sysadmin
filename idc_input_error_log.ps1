# Define the root directory
$rootDirectory = "C:\Users\Public\Downloads\IDC"

# Define the list of allowed subdirectories
$allowedSubdirs = @(
    "Vendor01",
    "Vendor02",
    "Vendor03"
)

# Initialize an array to hold the results
$results = @()

foreach ($subdir in $allowedSubdirs) {
    # Construct the path to the "Error files" folder in the allowed subdirectory
    $errorDirPath = Join-Path -Path (Join-Path -Path $rootDirectory -ChildPath $subdir) -ChildPath "Error files"
    
    # Check if the "Error files" folder exists
    if (Test-Path -Path $errorDirPath) {
        # Count the number of files in the "Error files" folder
        $fileCount = (Get-ChildItem -Path $errorDirPath).Count
        
        # Create a custom object to store the result if the file count is greater than 0
        if ($fileCount -gt 0) {
            $result = [PSCustomObject]@{
                ParentFolder = $subdir
                ErrorFileCount = $fileCount
            }

            # Add the result to the results array
            $results += $result
        }
    }
}

# Output the results
$results | Format-Table -AutoSize

# Save the results to a log file
$logFile = "C:\Users\Public\Downloads\IDC\0-ERRORS\error_log_$(Get-Date -Format 'yyyyMMdd').txt"
$results | Out-File -FilePath $logFile

# Schedule the script to run daily using Task Scheduler
# Use the following command to create a scheduled task (run this separately in a PowerShell with admin rights)
# Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument '-File C:\scripts\Epicor-IDC-Error-Log.ps1') -Trigger (New-ScheduledTaskTrigger -Daily -At 9am) -TaskName "Epicor IDC Import Error Log" -Description "Daily error log generation" -User "SYSTEM" -RunLevel Highest
