@echo off
:: Define output file
set "outputFile=system_info.txt"

:: Redirect output to file
(
    echo ===== Hard Drive Space =====
    wmic logicaldisk get size,freespace,caption

    echo.
    echo ===== Memory Information =====
    systeminfo | findstr /C:"Total Physical Memory"

    echo.
    echo ===== Processor Information =====
    wmic cpu get name, NumberOfCores, NumberOfLogicalProcessors

    echo.
    echo ===== Operating System Version =====
    ver

    echo.
    echo ===== Network Interfaces =====
    ipconfig /all

    echo.
    echo ===== Graphics Card Information =====
    wmic path win32_videocontroller get name 2>nul
    if %errorlevel% neq 0 (
        echo No graphics card detected.
    )

    echo.
    echo ===== Running Processes =====
    tasklist
) > "%outputFile%"

:: Notify user of completion
echo System information has been saved to %outputFile%
pause
