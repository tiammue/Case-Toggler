# Contributing to Case Toggler

Thank you for your interest in contributing to Case Toggler! This document provides guidelines for contributing to the project.

## 🚀 Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your fork locally
3. **Build** the project using `.\build.ps1` or `build.bat`
4. **Test** your changes thoroughly

## 🐛 Reporting Issues

When reporting issues, please include:
- **Windows version** and architecture (x64/x86)
- **Steps to reproduce** the issue
- **Expected behavior** vs actual behavior
- **Applications** where the issue occurs
- **Error messages** if any

## 💡 Suggesting Features

Feature requests are welcome! Please:
- **Check existing issues** to avoid duplicates
- **Describe the use case** clearly
- **Explain why** the feature would be valuable
- **Consider implementation complexity**

## 🔧 Development Guidelines

### Code Style
- Use **clear, descriptive variable names**
- Add **comments for complex logic**
- Follow **existing code formatting**
- Keep **functions focused and small**

### Testing
- Test on **multiple Windows versions** if possible
- Verify functionality in **different applications** (Word, Notepad, browsers)
- Test **edge cases** (empty selections, special characters)
- Ensure **clipboard preservation** works correctly

### Performance
- Avoid **arbitrary delays** - use smart waiting instead
- Minimize **memory allocations** in hot paths
- Test **response times** for user interactions
- Profile **CPU usage** during operation

## 📝 Pull Request Process

1. **Create a feature branch** from main
2. **Make your changes** with clear commit messages
3. **Test thoroughly** on your system
4. **Update documentation** if needed
5. **Submit pull request** with description of changes

### Commit Messages
- Use **present tense** ("Add feature" not "Added feature")
- Keep **first line under 50 characters**
- Add **detailed description** if needed
- Reference **issue numbers** when applicable

## 🏗️ Architecture Notes

### Key Components
- **TrayApplication.cs**: Main application logic and tray management
- **GlobalKeyboardHook.cs**: Low-level keyboard hook implementation
- **Program.cs**: Application entry point and initialization

### Important Considerations
- **Global keyboard hooks** require careful resource management
- **Clipboard operations** must be thread-safe and reliable
- **SendKeys timing** varies between applications
- **Memory leaks** can occur with improper hook disposal

## 🧪 Testing Scenarios

Please test these scenarios when making changes:
- **Text selection** in various applications
- **No selection** (should do nothing)
- **Empty clipboard** handling
- **Large text selections** (performance)
- **Special characters** and Unicode
- **Multiple rapid activations**
- **Application switching** during operation

## 📚 Resources

- [Windows Keyboard Hooks Documentation](https://docs.microsoft.com/en-us/windows/win32/winmsg/about-hooks)
- [SendKeys Class Reference](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.sendkeys)
- [Clipboard Class Reference](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.clipboard)

## 🤝 Code of Conduct

- Be **respectful** and **constructive** in discussions
- **Help others** learn and improve
- **Focus on the code**, not the person
- **Welcome newcomers** and different perspectives

## 📞 Questions?

Feel free to open an issue for questions about:
- **Development setup**
- **Architecture decisions**
- **Feature implementation**
- **Testing approaches**

Thank you for contributing to Case Toggler! 🎉