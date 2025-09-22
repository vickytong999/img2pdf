@echo off
echo =======================================
echo    Image to PDF Web Tool Installer
echo =======================================
echo.

where node >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] Node.js is installed
    node -v
) else (
    echo [ERROR] Node.js is not installed
    echo Please download and install Node.js from: https://nodejs.org/
    echo.
    pause
    exit /b 1
)

where img2pdf >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] img2pdf is installed
    img2pdf --version
) else (
    echo [WARNING] img2pdf is not installed
    echo.
    echo Installing img2pdf via pip...
    
    where pip >nul 2>&1
    if %errorlevel% == 0 (
        pip install img2pdf
    ) else (
        where pip3 >nul 2>&1
        if %errorlevel% == 0 (
            pip3 install img2pdf
        ) else (
            echo [ERROR] pip is not installed
            echo Please install Python and pip first
            echo Download Python from: https://www.python.org/downloads/
            echo.
            pause
            exit /b 1
        )
    )
    
    where img2pdf >nul 2>&1
    if %errorlevel% == 0 (
        echo [OK] img2pdf installed successfully
    ) else (
        echo [ERROR] Failed to install img2pdf
        echo Please install manually: pip install img2pdf
        pause
        exit /b 1
    )
)

echo.
echo Installing Node.js dependencies...
if exist package.json (
    call npm install
    if %errorlevel% == 0 (
        echo [OK] Dependencies installed successfully
    ) else (
        echo [ERROR] Failed to install dependencies
        pause
        exit /b 1
    )
) else (
    echo [ERROR] package.json not found
    pause
    exit /b 1
)

echo.
echo =======================================
echo         Installation Complete!
echo =======================================
echo.
echo To start the application:
echo   1. Run: npm start
echo   2. Or run: start.bat
echo   3. Open browser: http://localhost:3000
echo.
pause