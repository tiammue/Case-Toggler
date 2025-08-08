# Case Toggler

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![.NET Framework](https://img.shields.io/badge/.NET%20Framework-4.7.2+-purple.svg)](https://dotnet.microsoft.com/download/dotnet-framework)

A lightweight Windows tray application that instantly toggles text case with keyboard shortcuts. Perfect for quick text formatting without interrupting your workflow.

## ✨ Features

- 🎯 **Double-tap LEFT SHIFT**: Toggle case of selected text
- 🔤 **Triple-tap LEFT SHIFT**: Toggle first letter of current word
- 🪶 **Lightweight**: Runs quietly in system tray with minimal resource usage
- 🌐 **Universal**: Works in any Windows application (Word, browsers, editors, etc.)
- ⚡ **Fast**: Optimized for near-instantaneous response
- 🔒 **Safe**: Preserves your clipboard content

## 🚀 Quick Start

### Option 1: Installer (Recommended)
1. **Download** `CaseToggler-Setup-v1.0.0.exe` from [releases](https://github.com/tiammue/case-toggler/releases)
2. **Run the installer** and follow the setup wizard
3. **Launch automatically** or find "Case Toggler" in Start Menu
4. **Look** for the "Aa" icon in your system tray

### Option 2: Portable
1. **Download** `CaseToggler.exe` from [releases](https://github.com/tiammue/case-toggler/releases)
2. **Run** the executable (may require administrator privileges)
3. **Look** for the "Aa" icon in your system tray

**Ready to use!** Select text anywhere and double-tap LEFT SHIFT to toggle case!

## 📖 Usage Examples

| Action | Input | Output |
|--------|-------|--------|
| Double-tap on selection | `hello world` | `HELLO WORLD` |
| Double-tap on selection | `HELLO WORLD` | `hello world` |
| Triple-tap in word | cursor in `hello` | `Hello` |
| Triple-tap in word | cursor in `WORLD` | `wORLD` |

## ⏱️ Timing Settings

- **Double-tap window**: 300ms between taps
- **Triple-tap window**: 500ms total for all three taps
- **Clipboard timeout**: 200ms for application response

## 🛠️ Building from Source

### Requirements
- Windows OS
- .NET Framework 4.7.2+ (usually pre-installed)
- C# compiler (included with Windows)
- [Inno Setup 6](https://jrsoftware.org/isinfo.php) (for installer)

### Build Executable

**Option 1: PowerShell (Recommended)**
```powershell
.\build.ps1
```

**Option 2: Batch File**
```cmd
build.bat
```

### Build Installer

**Option 1: PowerShell**
```powershell
.\build-installer.ps1
```

**Option 2: Batch File**
```cmd
build-installer.bat
```

See [INSTALLER_README.md](INSTALLER_README.md) for detailed installer build instructions.

## 🏗️ Architecture

- **TrayApplication.cs**: Main application logic and UI
- **GlobalKeyboardHook.cs**: Low-level keyboard hook implementation
- **Program.cs**: Application entry point

The app uses:
- Windows Forms for tray interface
- Low-level keyboard hooks for global hotkey detection
- Clipboard operations with smart change detection
- SendKeys for text manipulation

## 🎛️ Configuration

Right-click the tray icon to access:
- **About**: View current timing settings and version info
- **Exit**: Close the application

## ⚠️ Important Notes

- **Administrator privileges** may be required for global keyboard hooks
- **Only affects letters** - numbers and symbols remain unchanged
- **Clipboard-safe** - your original clipboard content is always restored
- **Performance optimized** - uses smart waiting instead of fixed delays

## 📦 Download Options

| Download Type | File | Description |
|---------------|------|-------------|
| **Installer** | `CaseToggler-Setup-v1.0.0.exe` | Full installation with Start Menu, auto-startup option |
| **Portable** | `CaseToggler.exe` | Single executable, no installation required |

Both options are available in [GitHub Releases](https://github.com/tiammue/case-toggler/releases).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with Windows Forms and .NET Framework
- Inspired by the need for quick text case toggling in daily workflows