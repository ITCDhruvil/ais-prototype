@echo off
title AIS prototype (keep this window open)
rem Starts AIS on http://localhost:8765 so the Negotiation Desk can be reached. Close this window to stop it.
cd /d "%~dp0"

set PY=
where py >nul 2>nul && set PY=py -3
if "%PY%"=="" where python >nul 2>nul && set PY=python
if "%PY%"=="" (
  echo Python was not found. Install it from https://www.python.org/downloads/ ^(tick "Add python.exe to PATH"^) and run start.bat again.
  pause
  exit /b 1
)

echo Starting AIS on http://localhost:8765 ...
echo Keep this window open while you use AIS. Close it to stop.
echo.
start "" /b cmd /c "ping -n 3 127.0.0.1 >nul & start http://localhost:8765"
%PY% -m http.server 8765 --bind 127.0.0.1
if errorlevel 1 (
  echo.
  echo Could not start. If AIS is already running, open http://localhost:8765 in your browser.
  pause
)
