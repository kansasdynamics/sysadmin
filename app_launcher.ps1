# Quick Application Launcher

function Show-Menu {
    Clear-Host
    Write-Host "Quick Application Launcher" -ForegroundColor Green
    Write-Host "==========================" -ForegroundColor Green
    Write-Host "1. Open Visual Studio Code"
    Write-Host "2. Open Microsoft Word"
    Write-Host "3. Open Microsoft Edge (GitHub)"
    Write-Host "4. Open File Explorer"
    Write-Host "5. Exit"
}

function Launch-Application {
    param (
        [string]$choice
    )

    switch ($choice) {
        1 { 
            # Attempt to launch Visual Studio Code from default installation paths
            $vsCodePath1 = "C:\Program Files\Microsoft VS Code\Code.exe"
            $vsCodePath2 = "C:\Program Files (x86)\Microsoft VS Code\Code.exe"
            
            if (Test-Path $vsCodePath1) {
                Start-Process $vsCodePath1
            } elseif (Test-Path $vsCodePath2) {
                Start-Process $vsCodePath2
            } else {
                Write-Host "Visual Studio Code not found. Please check your installation." -ForegroundColor Red
            }
        }
        2 { Start-Process "winword.exe" }
        3 { Start-Process "msedge.exe" "https://www.github.com" }
        4 { Start-Process "explorer.exe" }
        5 { exit }
        default { Write-Host "Invalid selection. Please try again." -ForegroundColor Red }
    }
}

do {
    Show-Menu
    $choice = Read-Host "Select an option"
    Launch-Application -choice $choice
    Start-Sleep -Seconds 2
} while ($choice -ne 5)
