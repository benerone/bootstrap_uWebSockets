@echo off
::set CONFIG=Release
set PLATFORM=amd64
set VCPATH="C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build"

if not defined DevEnvDir (
    call %VCPATH%\vcvarsall.bat %PLATFORM%
)

@echo on
echo ----------------------- download libuv -----------------------------
curl -L -o libuv-1.50.0.tar.gz https://github.com/libuv/libuv/archive/refs/tags/v1.50.0.tar.gz
if %errorlevel% neq 0 (
    echo Failed to download Libuv. Error code: %errorlevel%
    exit /b %errorlevel%
)
tar -xzf libuv-1.50.0.tar.gz
del libuv-1.50.0.tar.gz
@echo off
cd  libuv-1.50.0
call :NORMALIZEPATH "..\..\vendor\libuv"
set LIBUV_INSTALL_DIR=%RETVAL%
if not exist %LIBUV_INSTALL_DIR% (
    mkdir %LIBUV_INSTALL_DIR%
)
@echo on


@echo off
setlocal

:: Set paths
set LIBUV_DIR=%CD%
set INSTALL_DIR=%LIBUV_INSTALL_DIR%
set BUILD_DIR=%LIBUV_DIR%\build


:: Ensure build directory exists
if not exist %BUILD_DIR% mkdir %BUILD_DIR%
if not exist %INSTALL_DIR% mkdir %INSTALL_DIR%

:: Move to build directory
cd /d %BUILD_DIR%

:: Configure with CMake
cmake -G "Visual Studio 17 2022" -A x64 -DCMAKE_INSTALL_PREFIX=%INSTALL_DIR% .. -DCMAKE_DEBUG_POSTFIX=d ..

:: Build and install
cmake --build . --config Release --target install
cmake --build . --config Debug --target install

:: Return to root directory
cd ../..

@echo on
echo =============================
echo Cleaning
echo =============================

::Clean
rmdir /s /q  libuv-1.50.0


echo.
echo =============================
echo LibUV has been built and installed in %INSTALL_DIR%
echo =============================
exit /B

:NORMALIZEPATH
  SET RETVAL=%~f1
  EXIT /B