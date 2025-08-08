[Setup]
; Basic Information
AppName=Case Toggler
AppVersion=1.0.0
AppPublisher=tiammue
AppPublisherURL=https://github.com/tiammue/case-toggler
AppSupportURL=https://github.com/tiammue/case-toggler/issues
AppUpdatesURL=https://github.com/tiammue/case-toggler/releases
DefaultDirName={autopf}\Case Toggler
DefaultGroupName=Case Toggler
AllowNoIcons=yes
LicenseFile=LICENSE
InfoBeforeFile=INSTALL.md
OutputDir=dist
OutputBaseFilename=CaseToggler-Setup-v1.0.0
SetupIconFile=
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesAllowed=x64 x86
ArchitecturesInstallIn64BitMode=x64

; Version Information
VersionInfoVersion=1.0.0.0
VersionInfoCompany=tiammue
VersionInfoDescription=Case Toggler Setup
VersionInfoCopyright=Copyright (C) 2025 tiammue
VersionInfoProductName=Case Toggler
VersionInfoProductVersion=1.0.0

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode
Name: "startup"; Description: "Start Case Toggler automatically when Windows starts"; GroupDescription: "Startup Options"; Flags: checked

[Files]
Source: "CaseToggler.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "CHANGELOG.md"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Case Toggler"; Filename: "{app}\CaseToggler.exe"
Name: "{group}\{cm:ProgramOnTheWeb,Case Toggler}"; Filename: "https://github.com/tiammue/case-toggler"
Name: "{group}\{cm:UninstallProgram,Case Toggler}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\Case Toggler"; Filename: "{app}\CaseToggler.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Case Toggler"; Filename: "{app}\CaseToggler.exe"; Tasks: quicklaunchicon

[Registry]
Root: HKCU; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "Case Toggler"; ValueData: "{app}\CaseToggler.exe"; Flags: uninsdeletevalue; Tasks: startup

[Run]
Filename: "{app}\CaseToggler.exe"; Description: "{cm:LaunchProgram,Case Toggler}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "taskkill"; Parameters: "/f /im CaseToggler.exe"; Flags: runhidden; RunOnceId: "StopCaseToggler"

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then
  begin
    // Stop Case Toggler if it's running
    Exec('taskkill', '/f /im CaseToggler.exe', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  end;
end;