@echo off
setlocal

set "CONFIG=Debug"
set "PLATFORM=Mixed Platforms"
set "SOLUTION=Nuake.sln"
set "MSBUILD_EXE="

if not "%~1"=="" set "CONFIG=%~1"
if not "%~2"=="" set "PLATFORM=%~2"

pushd "%~dp0\.." >nul || (
    echo Failed to enter repository root.
    exit /b 1
)

if not exist "%SOLUTION%" (
    echo %SOLUTION% not found. Run BuildScripts\generate-sln.bat first.
    popd >nul
    exit /b 1
)

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if exist "%VSWHERE%" (
    for /f "usebackq tokens=*" %%I in (`"%VSWHERE%" -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) do (
        set "MSBUILD_EXE=%%I"
    )
)

if not defined MSBUILD_EXE if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD_EXE=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if not defined MSBUILD_EXE if exist "C:\Program Files\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD_EXE=C:\Program Files\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe"

if not defined MSBUILD_EXE (
    echo Could not locate MSBuild.exe. Install Visual Studio 2022 Build Tools with MSBuild.
    popd >nul
    exit /b 1
)

echo Building "%SOLUTION%" with Configuration=%CONFIG% Platform=%PLATFORM%...
call "%MSBUILD_EXE%" "%SOLUTION%" /m /verbosity:minimal /p:Configuration=%CONFIG% /p:Platform="%PLATFORM%"
set "RC=%ERRORLEVEL%"

if not %RC%==0 if /I "%PLATFORM%"=="x64" (
    echo x64 solution platform failed, retrying with "Mixed Platforms"...
    set "PLATFORM=Mixed Platforms"
    call "%MSBUILD_EXE%" "%SOLUTION%" /m /verbosity:minimal /p:Configuration=%CONFIG% /p:Platform="%PLATFORM%"
    set "RC=%ERRORLEVEL%"
)

if %RC%==0 (
    echo Build succeeded.
) else (
    echo Build failed with exit code %RC%.
)

popd >nul
exit /b %RC%