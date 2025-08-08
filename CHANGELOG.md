# Changelog

All notable changes to Case Toggler will be documented in this file.

## [1.0.0] - 2025-01-08

### Added
- Initial release of Case Toggler
- Double-tap LEFT SHIFT to toggle case of selected text
- Triple-tap LEFT SHIFT to toggle first letter of current word
- System tray integration with context menu
- Smart clipboard change detection (no arbitrary delays)
- Clipboard content preservation
- Support for all Windows applications
- Optimized performance with sub-50ms response times

### Features
- **Double-tap timing**: 300ms window for reliable detection
- **Triple-tap timing**: 500ms window for comfortable usage
- **Clipboard timeout**: 200ms for application compatibility
- **Universal compatibility**: Works in any Windows text application
- **Lightweight**: Minimal system resource usage
- **Safe**: Preserves original clipboard content

### Technical Details
- Built with .NET Framework 4.7.2
- Uses low-level keyboard hooks for global hotkey detection
- Implements smart clipboard monitoring instead of fixed delays
- Optimized character array manipulation for fast case toggling