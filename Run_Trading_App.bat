@echo off
setlocal enabledelayedexpansion

:: Change working directory to the script's location
cd /d "%~dp0"

title RL Trading Environment - Startup
color 0b

echo ===================================================
echo     RL Trading Environment - Desktop App Launcher
echo ===================================================
echo.

:: 1. Check Python
where python >nul 2>nul
if %errorlevel% neq 0 (
    color 0c
    echo [ERROR] Python is not installed or not in PATH.
    echo Please install Python 3.9+ and try again.
    pause
    exit /b 1
)

:: 2. Setup Virtual Environment
echo [*] Checking Python virtual environment...
if not exist "backend\venv\Scripts\activate.bat" (
    echo [*] Creating virtual environment...
    python -m venv backend\venv
)

:: Activate venv
call backend\venv\Scripts\activate.bat

:: 3. Install Python Dependencies
if not exist "backend\.installed" (
    echo [*] Installing backend dependencies...
    pip install -r backend\requirements.txt >nul 2>&1
    if !errorlevel! neq 0 (
        echo [WARNING] Some dependencies may not have installed correctly.
        echo Attempting to continue anyway...
    ) else (
        echo. > "backend\.installed"
    )
)

:: 4. Generate Sample Data
echo [*] Checking for dataset...
if not exist "sample_data\sample_spy.csv" (
    echo [*] Generating sample market data...
    python sample_data\generate_sample.py >nul 2>&1
)

:: 5. Setup Frontend
echo [*] Checking frontend build...
if not exist "frontend\dist\index.html" (
    echo [*] Frontend not built. Building now...
    
    where npm >nul 2>nul
    if !errorlevel! neq 0 (
        color 0c
        echo [ERROR] Node.js ^(npm^) is required to build the frontend initially.
        echo Please install Node.js and try again.
        pause
        exit /b 1
    )
    
    cd frontend
    echo [*] Installing NPM packages...
    call npm install >nul 2>&1
    echo [*] Compiling React App...
    call npm run build >nul 2>&1
    cd ..
)

:: 6. Launch Application
echo.
echo ===================================================
echo     Starting Application...
echo     Please wait for the window to appear.
echo     Do NOT close this terminal window!
echo ===================================================
echo.

python app.py

:: Keep window open if app crashes
if %errorlevel% neq 0 (
    color 0c
    echo.
    echo [ERROR] Application crashed or exited unexpectedly.
    pause
)
