#Requires AutoHotkey v2.0

#include CoreLibrary.ahk

; run this script in powershell 
; Get-ChildItem -Path . -Recurse -Filter *.licx | ForEach-Object { Clear-Content $_.FullName }
; Get-ChildItem -Path "E:\Workspace\NGDev\Core" -Recurse -Filter *.licx | ForEach-Object { Clear-Content $_.FullName }


ClearLicxFiles() {
    targetPath := GetActiveExplorerOrDesktopPath()
    Run('powershell.exe -NoExit -Command "Get-ChildItem -Path ' . targetPath . ' -Recurse -Filter *.licx | ForEach-Object { Clear-Content $_.FullName }"')
}
