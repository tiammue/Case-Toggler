# Building the Case Toggler Installer

This project includes scripts to create a professional Windows installer using Inno Setup.

## 📋 Prerequisites

1. **Download Inno Setup 6** (free):
   - Visit: https://jrsoftware.org/isinfo.php
   - Download and install Inno Setup 6
   - Default installation path is recommended

## 🔨 Building the Installer

### Option 1: PowerShell (Recommended)
```powershell
.\build-installer.ps1
```

### Option 2: Batch File
```cmd
build-installer.bat
```

### Option 3: Manual
1. Build the exe: `.\build.ps1`
2. Open `installer.iss` in Inno Setup
3. Click "Build" → "Compile"

## 📦 Installer Features

The generated installer (`CaseToggler-Setup-v1.0.0.exe`) includes:

### ✨ Professional Features
- **Modern wizard interface** with progress bars
- **License agreement** display (MIT License)
- **Installation instructions** shown before install
- **Custom installation directory** selection
- **Start menu shortcuts** creation
- **Desktop shortcut** (optional)
- **Automatic startup** option (enabled by default)

### 🔧 Smart Installation
- **Stops running instance** before installing
- **Administrator privileges** automatically requested
- **Uninstaller creation** with proper cleanup
- **Registry entries** for startup (if selected)
- **File association** and version info

### 📁 Installed Files
- `CaseToggler.exe` (main application)
- `README.md` (documentation)
- `LICENSE` (license file)
- `CHANGELOG.md` (version history)

### 🗂️ Start Menu Items
- **Case Toggler** (launch application)
- **Visit Website** (GitHub repository)
- **Uninstall** (remove application)

## 🎯 Distribution

After building, you'll have:
- `dist/CaseToggler-Setup-v1.0.0.exe` (installer)
- Ready for distribution on GitHub releases
- Digitally signable (optional, requires code signing certificate)

## 🔄 Updating the Installer

To update for new versions:
1. Edit version in `installer.iss` (line 4: `AppVersion=1.0.0`)
2. Update `OutputBaseFilename` to match new version
3. Rebuild with build scripts

## 🛡️ Security Notes

- **Unsigned installer**: Windows may show SmartScreen warning
- **Code signing**: Consider purchasing certificate for production
- **Antivirus**: Some may flag due to keyboard hooks (false positive)

## 📝 Customization

Edit `installer.iss` to customize:
- **Company information** (lines 5-8)
- **Installation options** (Tasks section)
- **File inclusions** (Files section)
- **Registry entries** (Registry section)
- **Startup behavior** (Run section)

The installer provides a professional installation experience while maintaining the lightweight nature of Case Toggler!