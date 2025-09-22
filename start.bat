@echo off
echo =======================================
echo    Starting Image to PDF Web Tool
echo =======================================
echo.

where node >nul 2>&1
if not %errorlevel% == 0 (
    echo [ERROR] Node.js is not installed
    echo Please run: install.bat
    pause
    exit /b 1
)

where img2pdf >nul 2>&1
if not %errorlevel% == 0 (
    echo [ERROR] img2pdf is not installed
    echo Please run: install.bat
    pause
    exit /b 1
)

if not exist node_modules (
    echo [INFO] Dependencies not installed, installing...
    call npm install
    if not %errorlevel% == 0 (
        echo [ERROR] Failed to install dependencies
        pause
        exit /b 1
    )
)

echo [OK] All dependencies are ready
echo.
echo Starting server...
echo.

timeout /t 2 /nobreak >nul
start http://localhost:3000

npm start