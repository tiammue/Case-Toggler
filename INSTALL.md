# Installation Guide

## 🚀 Quick Install (Recommended)

1. **Download** `CaseToggler.exe` from the [latest release](https://github.com/yourusername/case-toggler/releases)
2. **Save** to any folder (e.g., `C:\Tools\` or `Desktop`)
3. **Right-click** → "Run as administrator" (recommended)
4. **Look** for the "Aa" icon in your system tray

That's it! No installation wizard, no registry changes.

## 🔧 Alternative: Build from Source

```powershell
# Clone the repository
git clone https://github.com/yourusername/case-toggler.git
cd case-toggler

# Build using PowerShell
.\build.ps1

# Or build using batch file
build.bat
```

## ⚙️ Startup Configuration

**To run automatically on Windows startup:**

1. **Press** `Win + R`
2. **Type** `shell:startup` and press Enter
3. **Copy** `CaseToggler.exe` to this folder
4. **Restart** Windows

## 🛡️ Security Considerations

- **Windows SmartScreen**: May show warning for unsigned executable
- **Antivirus**: Might flag due to keyboard hooks (false positive)
- **Administrator rights**: Required for global hotkey functionality

## 🔄 Updating

1. **Close** Case Toggler (right-click tray icon → Exit)
2. **Replace** the old exe with the new version
3. **Run** the new version

## 🗑️ Uninstalling

1. **Close** Case Toggler (right-click tray icon → Exit)
2. **Delete** `CaseToggler.exe`
3. **Remove** from startup folder if added

No registry cleanup needed - it's completely portable!

## ❓ Troubleshooting

**Not working?**
- Try running as administrator
- Check if antivirus is blocking it
- Ensure .NET Framework 4.7.2+ is installed

**Can't see tray icon?**
- Check hidden icons in system tray
- Look for "Aa" blue icon

**Still having issues?**
- Open an issue on GitHub with your Windows version and error details