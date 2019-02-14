@echo off

where cmake.exe >nul 2>nul
IF ERRORLEVEL 1 (
    echo cmake.exe not found in path.
    exit /b 3
)

exit /b 0