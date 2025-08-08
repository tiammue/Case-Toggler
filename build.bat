@echo off
echo Building Case Toggler...

REM Find the .NET Framework directory
set DOTNET_DIR=%WINDIR%\Microsoft.NET\Framework64\v4.0.30319
if not exist "%DOTNET_DIR%\csc.exe" (
    set DOTNET_DIR=%WINDIR%\Microsoft.NET\Framework\v4.0.30319
)

if not exist "%DOTNET_DIR%\csc.exe" (
    echo Error: C# compiler not found. Please install .NET Framework 4.7.2 or later.
    pause
    exit /b 1
)

REM Compile the application
"%DOTNET_DIR%\csc.exe" /target:winexe /out:CaseToggler.exe /reference:System.dll /reference:System.Core.dll /reference:System.Drawing.dll /reference:System.Windows.Forms.dll Program.cs TrayApplication.cs GlobalKeyboardHook.cs

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Build successful! CaseToggler.exe created.
    echo.
    echo To run: CaseToggler.exe
    echo Note: You may need to run as administrator for global keyboard hooks to work.
) else (
    echo.
    echo Build failed!
)

pause