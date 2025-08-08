# PowerShell build script for Case Toggler
Write-Host "Building Case Toggler..." -ForegroundColor Green

# Check if source files exist
$sourceFiles = @("Program.cs", "TrayApplication.cs", "GlobalKeyboardHook.cs")
foreach ($file in $sourceFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "Error: Source file '$file' not found." -ForegroundColor Red
        if ($env:GITHUB_ACTIONS -ne "true") {
            Read-Host "Press Enter to continue"
        }
        exit 1
    }
}

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
    if ($env:GITHUB_ACTIONS -ne "true") {
        Read-Host "Press Enter to continue"
    }
    exit 1
}

Write-Host "Using compiler: $cscPath" -ForegroundColor Yellow

# Remove existing executable if it exists
if (Test-Path "CaseToggler.exe") {
    Remove-Item "CaseToggler.exe" -Force
    Write-Host "Removed existing CaseToggler.exe" -ForegroundColor Yellow
}

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

Write-Host "Compiling with arguments: $($compileArgs -join ' ')" -ForegroundColor Yellow
& $cscPath $compileArgs

if ($LASTEXITCODE -eq 0) {
    # Verify the executable was actually created
    if (Test-Path "CaseToggler.exe") {
        Write-Host ""
        Write-Host "Build successful! CaseToggler.exe created." -ForegroundColor Green
        Write-Host ""
        Write-Host "To run: .\CaseToggler.exe" -ForegroundColor Cyan
        Write-Host "Note: You may need to run as administrator for global keyboard hooks to work." -ForegroundColor Yellow
    } else {
        Write-Host ""
        Write-Host "Build failed! Executable not created despite successful compilation." -ForegroundColor Red
        if ($env:GITHUB_ACTIONS -ne "true") {
            Read-Host "Press Enter to continue"
        }
        exit 1
    }
} else {
    Write-Host ""
    Write-Host "Build failed! Compilation returned error code: $LASTEXITCODE" -ForegroundColor Red
    if ($env:GITHUB_ACTIONS -ne "true") {
        Read-Host "Press Enter to continue"
    }
    exit 1
}

# Only pause if not running in GitHub Actions
if ($env:GITHUB_ACTIONS -ne "true") {
    Read-Host "Press Enter to continue"
}
