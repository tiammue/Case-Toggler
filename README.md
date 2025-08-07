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

1. **Download** the latest release or build from source
2. **Run** `CaseToggler.exe` (may require administrator privileges)
3. **Look** for the "Aa" icon in your system tray
4. **Select text** and double-tap LEFT SHIFT to toggle case!

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

### Build Options

**Option 1: PowerShell (Recommended)**
```powershell
.\build.ps1
```

**Option 2: Batch File**
```cmd
build.bat
```

**Option 3: Manual**
```cmd
csc.exe /target:winexe /out:CaseToggler.exe /reference:System.dll /reference:System.Core.dll /reference:System.Drawing.dll /reference:System.Windows.Forms.dll Program.cs TrayApplication.cs GlobalKeyboardHook.cs
```

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

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with Windows Forms and .NET Framework
- Inspired by the need for quick text case toggling in daily workflows