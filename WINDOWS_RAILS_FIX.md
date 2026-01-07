# Rails on Windows - Port 3000 Restart Loop Fix

## Problem
Rails 8.1.1 with Puma 7.1.0 on Windows enters a restart loop where:
1. Server starts successfully
2. Attempts automatic restart
3. Crashes with `Errno::EADDRINUSE` (port 3000 already in use)
4. Windows doesn't release the port fast enough

## Root Cause
- **Puma's `tmp_restart` plugin** triggers automatic restarts
- **Rails 8.1's file watching** (`config.enable_reloading = true`) detects changes
- **Windows port binding delay** - Windows takes longer to release ports than Unix-based systems
- Result: Puma tries to bind to port 3000 while it's still locked by the previous instance

## ✅ Solutions Applied

### 1. **Disabled Puma Restart Plugin** ⭐ (Main Fix)
**File:** `config/puma.rb`

The `tmp_restart` plugin has been disabled as it causes restart loops on Windows:
```ruby
# Allow puma to be restarted by `bin/rails restart` command.
# Disabled on Windows due to port binding issues
# plugin :tmp_restart
```

**This is the primary fix that solves the restart loop issue.**

### 2. **Windows-Specific Puma Configuration**
**File:** `config/puma.rb`

Added configuration to force single-mode operation (no workers on Windows):
```ruby
# Windows-specific: Force single mode (no workers on Windows)
if Gem.win_platform?
  workers 0
end
```

### 3. **Fixed bin/rails Shebang**
**File:** `bin/rails`

Changed from `#!/usr/bin/env ruby.exe` to `#!/usr/bin/env ruby` for better compatibility.

### 4. **Helper Scripts**
Created two helper scripts to kill stuck processes:

- **PowerShell:** `bin/kill_rails.ps1` (recommended)
- **Batch:** `bin/kill_rails.bat`

## 🚀 How to Use

### Starting the Server
1. **Kill any stuck processes first:**
   ```powershell
   # PowerShell
   .\bin\kill_rails.ps1
   
   # OR Command Prompt
   bin\kill_rails.bat
   ```

2. **Start Rails server:**
   ```bash
   rails s
   ```

### If Port 3000 is Still Locked

**Option A: Use the helper scripts**
```powershell
.\bin\kill_rails.ps1
```

**Option B: Manual cleanup**
```powershell
# Find process using port 3000
netstat -ano | findstr :3000

# Kill the process (replace PID with actual process ID)
taskkill /F /PID <PID>
```

**Option C: Use a different port**
```bash
rails s -p 3001
```

## 📝 Recommended Workflow

1. **Before starting Rails:**
   ```powershell
   .\bin\kill_rails.ps1    # Clean up any stuck processes
   rails s                  # Start server
   ```

2. **To restart the server:**
   - ~~Don't use `bin/rails restart`~~ (disabled on Windows)
   - Instead: Press `Ctrl+C` → wait 2-3 seconds → `rails s`

3. **If you get EADDRINUSE error:**
   ```powershell
   # Terminal 1: Stop with Ctrl+C
   # Wait 3-5 seconds for port release
   # OR run: .\bin\kill_rails.ps1
   rails s
   ```

## 🔧 Additional Notes

### VIPS Warnings (Secondary Issue)
The VIPS warnings about missing DLLs are non-critical:
```
(process:XXXX): VIPS-WARNING **: unable to load vips-heif.dll
```

These are optional image processing modules. Your app will work fine without them unless you specifically need:
- HEIF/HEIC image support
- JXL (JPEG XL) support  
- ImageMagick integration
- OpenSlide support
- Poppler PDF rendering

To fix VIPS warnings (optional):
```bash
# Install libvips with all modules via MSYS2
ridk exec pacman -S mingw-w64-ucrt-x86_64-libvips
```

### Why This Happens on Windows
1. **Unix signal handling** - Windows doesn't support SIGUSR1, SIGUSR2, SIGHUP (hence the warnings)
2. **Port binding** - Windows TCP/IP stack holds ports in TIME_WAIT state longer
3. **File watching** - Windows file change events can be more aggressive than Unix

### Alternative: Use WSL2
For the best Rails development experience on Windows, consider using WSL2 (Windows Subsystem for Linux):
```bash
# In WSL2 Ubuntu/Debian
wsl --install
# Then install Ruby and Rails in WSL2 environment
```

## 🎯 Quick Reference

| Command | Purpose |
|---------|---------|
| `.\bin\kill_rails.ps1` | Kill stuck Rails/Ruby processes |
| `rails s` | Start Rails server on port 3000 |
| `rails s -p 3001` | Start on alternative port |
| `netstat -ano \| findstr :3000` | Check what's using port 3000 |
| `taskkill /F /PID <PID>` | Force kill specific process |

## ✅ Success Indicators

After applying these fixes, you should see:
```
=> Booting Puma
=> Rails 8.1.1 application starting in development
Puma starting in single mode...
* Listening on http://127.0.0.1:3000
Use Ctrl-C to stop
```

**No more "Restarting..." messages!**
