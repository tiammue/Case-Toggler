# PowerShell script to build Case Toggler installer
Write-Host "Building Case Toggler Installer..." -ForegroundColor Green
Write-Host ""

# Check if Inno Setup is installed
$InnoPath = @(
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
    "C:\Program Files\Inno Setup 6\ISCC.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $InnoPath) {
    Write-Host "Error: Inno Setup 6 not found!" -ForegroundColor Red
    Write-Host "Please download and install Inno Setup from: https://jrsoftware.org/isinfo.php" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Expected locations:" -ForegroundColor Yellow
    Write-Host "- C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
    Write-Host "- C:\Program Files\Inno Setup 6\ISCC.exe"
    Read-Host "Press Enter to continue"
    exit 1
}

# Build the application first
Write-Host "Building Case Toggler executable..." -ForegroundColor Yellow
& .\build.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to build CaseToggler.exe" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

# Create dist directory
if (-not (Test-Path "dist")) {
    New-Item -ItemType Directory -Path "dist" | Out-Null
}

# Build the installer
Write-Host ""
Write-Host "Building installer with Inno Setup..." -ForegroundColor Yellow
& $InnoPath "installer.iss"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Installer built successfully!" -ForegroundColor Green
    Write-Host "Location: dist\CaseToggler-Setup-v1.0.0.exe" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "You can now distribute this installer file." -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "❌ Installer build failed!" -ForegroundColor Red
}

Read-Host "Press Enter to continue"