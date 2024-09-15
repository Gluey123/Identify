@echo off
setlocal

REM Define the output file
set OUTPUT_FILE=installed_apps.txt

REM Create or clear the output file
echo Creating or clearing the output file...
echo. > "%OUTPUT_FILE%"

REM Append header
echo ===== Installed Applications (WMIC) ===== >> "%OUTPUT_FILE%"

REM List installed applications using WMIC
wmic product get name,version >> "%OUTPUT_FILE%" 2>nul

REM Check if WMIC worked
if %ERRORLEVEL% neq 0 (
    echo WMIC failed. Trying PowerShell... >> "%OUTPUT_FILE%"
) else (
    echo WMIC command succeeded. >> "%OUTPUT_FILE%"
)

REM Append header for PowerShell
echo. >> "%OUTPUT_FILE%"
echo ===== Installed Applications (PowerShell) ===== >> "%OUTPUT_FILE%"

REM List installed applications using PowerShell (Get-WmiObject)
powershell -Command "Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Format-Table -AutoSize | Out-File -FilePath '%OUTPUT_FILE%' -Append" 2>nul

REM Append header for Winget
echo. >> "%OUTPUT_FILE%"
echo ===== Installed Applications (Winget) ===== >> "%OUTPUT_FILE%"

REM Check if winget is available
where winget

