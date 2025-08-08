@echo off
echo Building Case Toggler Installer...
echo.

REM Check if Inno Setup is installed
set INNO_PATH="C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if not exist %INNO_PATH% (
    set INNO_PATH="C:\Program Files\Inno Setup 6\ISCC.exe"
)

if not exist %INNO_PATH% (
    echo Error: Inno Setup 6 not found!
    echo Please download and install Inno Setup from: https://jrsoftware.org/isinfo.php
    echo.
    echo Expected locations:
    echo - C:\Program Files (x86)\Inno Setup 6\ISCC.exe
    echo - C:\Program Files\Inno Setup 6\ISCC.exe
    pause
    exit /b 1
)

REM Build the application first
echo Building Case Toggler executable...
call build.bat
if %ERRORLEVEL% NEQ 0 (
    echo Failed to build Case Toggler.exe
    pause
    exit /b 1
)

REM Create dist directory
if not exist "dist" mkdir "dist"

REM Build the installer
echo.
echo Building installer with Inno Setup...
%INNO_PATH% "installer.iss"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ Installer built successfully!
    echo Location: dist\CaseToggler-Setup-v1.0.0.exe
    echo.
    echo You can now distribute this installer file.
) else (
    echo.
    echo ❌ Installer build failed!
)

pause