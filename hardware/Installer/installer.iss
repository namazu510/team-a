[Setup]
AppName=WeightLossFat
AppVersion=1.0
DefaultDirName=C:\Program Files (x86)\WLF
DefaultGroupName=WeightLossFat
UninstallDisplayIcon={app}\WLF.exe
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=setup
OutputDir=userdocs:WLFInstaller 

[Files]
Source:"WLF.exe";DestDir:"{app}"

[Icons]
Name:"{group}\WeightLossFat";FileName:"{app}\WLF.exe"
Name: "{commonstartup}\WeightLossFat"; Filename: "{app}\WLF.exe"

[Languages]
Name:japanese;MessagesFile:compiler:Languages\Japanese.isl