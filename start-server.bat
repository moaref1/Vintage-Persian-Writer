@echo off
REM Vintage Persian Writing Interface - Local Server Launcher
REM This script starts a local HTTP server and opens the browser

echo Starting Local Server...
echo.

REM Get the directory where this script is located
cd /d "%~dp0"

REM Start server in background and capture the port
start "" python -m http.server 8000

REM Wait for server to start
timeout /t 2 /nobreak

REM Open browser automatically
start http://localhost:8000

echo.
echo Server started! Opening http://localhost:8000 in your browser...
echo.
echo Press Ctrl+C in the command prompt to stop the server.
echo.

REM Keep the window open and running the server
pause
