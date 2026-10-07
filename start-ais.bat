@echo off
rem Starts AIS on http://localhost:8765 so the Negotiation Desk can be reached. Close this window to stop it.
cd /d "%~dp0"
where py >/dev/null 2>nul
if %errorlevel%==0 (set PY=py -3) else (set PY=python)
start "" /b cmd /c "ping -n 3 127.0.0.1 >/dev/null & start http://localhost:8765"
%PY% -m http.server 8765 --bind 127.0.0.1
if errorlevel 1 echo.& echo Python was not found. Install it from https://www.python.org/downloads/ and run this file again.& pause
