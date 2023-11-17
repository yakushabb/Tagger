; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Nickvision Tagger"
#define MyAppShortName "Tagger"
#define MyAppVersion "2023.11.2"
#define MyAppPublisher "Nickvision"
#define MyAppURL "https://nickvision.org"
#define MyAppExeName "NickvisionTagger.WinUI.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{CE1D8528-98EC-467D-A356-E95E7408253C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
UsePreviousAppDir=no
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=..\..\LICENSE
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=..\Installer
OutputBaseFilename=NickvisionTaggerSetup
SetupIconFile=..\Resources\org.nickvision.tagger.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
DirExistsWarning=no
CloseApplications=force

[Code]
procedure SetupDotnet();
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{app}\deps\dotnet-runtime-8-win-x64.exe'), '/install /quiet /norestart', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Unable to install .NET . Please try again', mbError, MB_OK);
end;

procedure SetupWinAppSDK();
var
  ResultCode: Integer;
begin
  if not Exec(ExpandConstant('{app}\deps\WindowsAppRuntimeInstall-x64.exe'), '--quiet', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
  then
    MsgBox('Unable to install Windows App SDK. Please try again', mbError, MB_OK);
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\..\..\dotnet-runtime-8-win-x64.exe"; DestDir: "{app}\deps"; AfterInstall: SetupDotnet  
Source: "..\..\..\WindowsAppRuntimeInstall-x64.exe"; DestDir: "{app}\deps"; AfterInstall: SetupWinAppSDK  
Source: "..\bin\x64\Debug\net8.0-windows10.0.19041.0\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion 
Source: "..\bin\x64\Debug\net8.0-windows10.0.19041.0\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppShortName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppShortName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

