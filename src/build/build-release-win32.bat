@echo off
setlocal

set "REPO_ROOT=%~dp0..\.."
set "BUILD_DIR=%REPO_ROOT%\buildx86"

cmake -S "%REPO_ROOT%\src" -B "%BUILD_DIR%" -G "Visual Studio 17 2022" -A Win32
if errorlevel 1 exit /b %errorlevel%

cmake --build "%BUILD_DIR%" --config Release --parallel
if errorlevel 1 exit /b %errorlevel%

echo Built %BUILD_DIR%\Release\rp-win.exe
