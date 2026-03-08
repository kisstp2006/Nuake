@echo off
setlocal

pushd "%~dp0\.." >nul || (
	echo Failed to enter repository root.
	exit /b 1
)

set "PREMAKE_EXE="

if exist "%CD%\BuildScripts\Tools\premake\premake5.exe" set "PREMAKE_EXE=%CD%\BuildScripts\Tools\premake\premake5.exe"
if exist "%CD%\premake5.exe" set "PREMAKE_EXE=%CD%\premake5.exe"
if not defined PREMAKE_EXE if exist "%CD%\BuildScripts\premake5.exe" set "PREMAKE_EXE=%CD%\BuildScripts\premake5.exe"
if not defined PREMAKE_EXE if exist "%CD%\Nuake\Vendors\wren\projects\premake\premake5.exe" set "PREMAKE_EXE=%CD%\Nuake\Vendors\wren\projects\premake\premake5.exe"
if not defined PREMAKE_EXE set "PREMAKE_EXE=premake5"

echo Generating Visual Studio solution with "%PREMAKE_EXE%"...
call "%PREMAKE_EXE%" vs2022
set "RC=%ERRORLEVEL%"

popd >nul
exit /b %RC%