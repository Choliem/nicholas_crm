# PowerShell script to kill any Ruby/Rails processes on port 3000
# Usage: .\bin\kill_rails.ps1

Write-Host "Checking for processes using port 3000..." -ForegroundColor Cyan

# Find processes using port 3000
$processes = netstat -ano | Select-String ":3000" | ForEach-Object {
    $line = $_.Line
    if ($line -match "\s+(\d+)$") {
        $matches[1]
    }
} | Select-Object -Unique

if ($processes) {
    Write-Host "Found processes using port 3000. Attempting to kill..." -ForegroundColor Yellow
    
    foreach ($processId in $processes) {
        try {
            $processInfo = Get-Process -Id $processId -ErrorAction SilentlyContinue
            if ($processInfo) {
                Write-Host "Killing process: $($processInfo.Name) (PID: $processId)" -ForegroundColor Red
                Stop-Process -Id $processId -Force
                Write-Host "[OK] Process $processId killed successfully" -ForegroundColor Green
            }
        }
        catch {
            Write-Host "Could not kill process $processId (may already be terminated)" -ForegroundColor DarkYellow
        }
    }
    
    # Wait a moment for ports to be released
    Start-Sleep -Seconds 2
    Write-Host "`n[OK] Port 3000 should now be available" -ForegroundColor Green
}
else {
    Write-Host "[OK] No processes found using port 3000" -ForegroundColor Green
}

# Clean up any stale PID files
$pidFile = "tmp/pids/server.pid"
if (Test-Path $pidFile) {
    Remove-Item $pidFile -Force
    Write-Host "[OK] Cleaned up stale PID file" -ForegroundColor Green
}

# Also check for any ruby.exe processes and offer to kill them
$rubyProcesses = Get-Process -Name ruby -ErrorAction SilentlyContinue

if ($rubyProcesses) {
    Write-Host "`nFound the following Ruby processes:" -ForegroundColor Cyan
    $rubyProcesses | Format-Table Id, ProcessName, StartTime -AutoSize
    
    $response = Read-Host "`nDo you want to kill all Ruby processes? (y/N)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        $rubyProcesses | ForEach-Object {
            try {
                Stop-Process -Id $_.Id -Force
                Write-Host "[OK] Killed Ruby process (PID: $($_.Id))" -ForegroundColor Green
            }
            catch {
                Write-Host "Could not kill process $($_.Id)" -ForegroundColor DarkYellow
            }
        }
    }
}

Write-Host "`n[OK] Done! You can now run 'rails s' again." -ForegroundColor Green
