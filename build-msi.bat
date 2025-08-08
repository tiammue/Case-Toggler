@echo off
echo Building Case Toggler MSI Installer...
echo.

REM Check if WiX Toolset is installed
set WIX_PATH="C:\Program Files (x86)\WiX Toolset v3.11\bin\candle.exe"
if not exist %WIX_PATH% (
    set WIX_PATH="C:\Program Files\WiX Toolset v3.11\bin\candle.exe"
)

if not exist %WIX_PATH% (
    echo Error: WiX Toolset v3.11 not found!
    echo Please download and install WiX Toolset from:
    echo https://github.com/wixtoolset/wix3/releases
    echo.
    echo Expected locations:
    echo - C:\Program Files (x86)\WiX Toolset v3.11\bin\
    echo - C:\Program Files\WiX Toolset v3.11\bin\
    pause
    exit /b 1
)

REM Set WiX paths
for %%i in (%WIX_PATH%) do set WIX_DIR=%%~dpi
set CANDLE_PATH=%WIX_DIR%candle.exe
set LIGHT_PATH=%WIX_DIR%light.exe

echo Using WiX Toolset at: %WIX_DIR%

REM Build the application first
echo Building Case Toggler executable...
call build.bat
if %ERRORLEVEL% NEQ 0 (
    echo Failed to build CaseToggler.exe
    pause
    exit /b 1
)

REM Create dist directory
if not exist "dist" mkdir "dist"

REM Compile WiX source
echo.
echo Compiling WiX source...
"%CANDLE_PATH%" "CaseToggler.wxs" -out "dist\CaseToggler.wixobj"
if %ERRORLEVEL% NEQ 0 (
    echo WiX compilation failed!
    pause
    exit /b 1
)

REM Link to create MSI
echo Creating MSI package...
"%LIGHT_PATH%" "dist\CaseToggler.wixobj" -ext WixUIExtension -out "dist\CaseToggler-Setup-v1.0.0.msi"
if %ERRORLEVEL% NEQ 0 (
    echo MSI creation failed!
    pause
    exit /b 1
)

REM Clean up intermediate files
del "dist\CaseToggler.wixobj" 2>nul

if exist "dist\CaseToggler-Setup-v1.0.0.msi" (
    echo.
    echo ✅ MSI installer built successfully!
    echo Location: dist\CaseToggler-Setup-v1.0.0.msi
    echo.
    echo The MSI installer includes:
    echo • Professional Windows Installer experience
    echo • Start Menu shortcuts
    echo • Optional desktop shortcut
    echo • Auto-startup configuration
    echo • Proper uninstallation support
    echo.
    echo You can now distribute this MSI file!
) else (
    echo.
    echo ❌ MSI creation failed!
)

pause