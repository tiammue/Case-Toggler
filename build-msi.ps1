# PowerShell script to build Case Toggler MSI installer
Write-Host "Building Case Toggler MSI Installer..." -ForegroundColor Green
Write-Host ""

# Check if WiX Toolset is installed
$WixPath = @(
    "C:\Program Files (x86)\WiX Toolset v3.11\bin\candle.exe",
    "C:\Program Files\WiX Toolset v3.11\bin\candle.exe",
    "${env:ProgramFiles(x86)}\WiX Toolset v3.11\bin\candle.exe",
    "$env:ProgramFiles\WiX Toolset v3.11\bin\candle.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $WixPath) {
    Write-Host "WiX Toolset not found. Installing..." -ForegroundColor Yellow
    
    # Download and install WiX Toolset
    $wixUrl = "https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311.exe"
    $wixInstaller = "wix311.exe"
    
    try {
        Write-Host "Downloading WiX Toolset..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $wixUrl -OutFile $wixInstaller
        
        Write-Host "Installing WiX Toolset (this may take a moment)..." -ForegroundColor Yellow
        Start-Process -FilePath $wixInstaller -ArgumentList "/quiet" -Wait
        
        Remove-Item $wixInstaller -ErrorAction SilentlyContinue
        
        # Try to find WiX again
        $WixPath = @(
            "C:\Program Files (x86)\WiX Toolset v3.11\bin\candle.exe",
            "C:\Program Files\WiX Toolset v3.11\bin\candle.exe"
        ) | Where-Object { Test-Path $_ } | Select-Object -First 1
        
        if (-not $WixPath) {
            Write-Host "WiX installation failed. Please install manually from:" -ForegroundColor Red
            Write-Host "https://github.com/wixtoolset/wix3/releases" -ForegroundColor Yellow
            Read-Host "Press Enter to continue"
            exit 1
        }
        
        Write-Host "WiX Toolset installed successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to download/install WiX Toolset: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Please install manually from: https://github.com/wixtoolset/wix3/releases" -ForegroundColor Yellow
        Read-Host "Press Enter to continue"
        exit 1
    }
}

$WixDir = Split-Path $WixPath
$CandlePath = Join-Path $WixDir "candle.exe"
$LightPath = Join-Path $WixDir "light.exe"

Write-Host "Using WiX Toolset at: $WixDir" -ForegroundColor Cyan

# Build the application first
Write-Host "Building Case Toggler executable..." -ForegroundColor Yellow
& .\build.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to build CaseToggler.exe" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

# Create output directory
if (-not (Test-Path "dist")) {
    New-Item -ItemType Directory -Path "dist" | Out-Null
}

# Compile WiX source
Write-Host "Compiling WiX source..." -ForegroundColor Yellow
& $CandlePath "CaseToggler.wxs" -out "dist\CaseToggler.wixobj"
if ($LASTEXITCODE -ne 0) {
    Write-Host "WiX compilation failed!" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

# Link to create MSI
Write-Host "Creating MSI package..." -ForegroundColor Yellow
& $LightPath "dist\CaseToggler.wixobj" -ext WixUIExtension -out "dist\CaseToggler-Setup-v1.0.0.msi"
if ($LASTEXITCODE -ne 0) {
    Write-Host "MSI creation failed!" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

# Clean up intermediate files
Remove-Item "dist\CaseToggler.wixobj" -ErrorAction SilentlyContinue

if (Test-Path "dist\CaseToggler-Setup-v1.0.0.msi") {
    Write-Host ""
    Write-Host "✅ MSI installer built successfully!" -ForegroundColor Green
    Write-Host "Location: dist\CaseToggler-Setup-v1.0.0.msi" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "The MSI installer includes:" -ForegroundColor Green
    Write-Host "• Professional Windows Installer experience" -ForegroundColor White
    Write-Host "• Start Menu shortcuts" -ForegroundColor White
    Write-Host "• Optional desktop shortcut" -ForegroundColor White
    Write-Host "• Auto-startup configuration" -ForegroundColor White
    Write-Host "• Proper uninstallation support" -ForegroundColor White
    Write-Host ""
    Write-Host "You can now distribute this MSI file!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "❌ MSI creation failed!" -ForegroundColor Red
}

Read-Host "Press Enter to continue"