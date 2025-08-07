# PowerShell build script for Case Toggler
Write-Host "Building Case Toggler..." -ForegroundColor Green

# Find the .NET Framework C# compiler
$dotnetDirs = @(
    "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319",
    "$env:WINDIR\Microsoft.NET\Framework\v4.0.30319"
)

$cscPath = $null
foreach ($dir in $dotnetDirs) {
    $testPath = Join-Path $dir "csc.exe"
    if (Test-Path $testPath) {
        $cscPath = $testPath
        break
    }
}

if (-not $cscPath) {
    Write-Host "Error: C# compiler not found. Please install .NET Framework 4.7.2 or later." -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host "Using compiler: $cscPath" -ForegroundColor Yellow

# Compile the application
$compileArgs = @(
    "/target:winexe",
    "/out:CaseToggler.exe",
    "/reference:System.dll",
    "/reference:System.Core.dll", 
    "/reference:System.Drawing.dll",
    "/reference:System.Windows.Forms.dll",
    "Program.cs",
    "TrayApplication.cs", 
    "GlobalKeyboardHook.cs"
)

& $cscPath $compileArgs

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Build successful! CaseToggler.exe created." -ForegroundColor Green
    Write-Host ""
    Write-Host "To run: .\CaseToggler.exe" -ForegroundColor Cyan
    Write-Host "Note: You may need to run as administrator for global keyboard hooks to work." -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "Build failed!" -ForegroundColor Red
}

Read-Host "Press Enter to continue"