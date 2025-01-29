:: Build openssl based on https://developernote.com/2022/04/building-openssl-3-0-2-with-msvc-2022/
@echo off
setlocal
::set CONFIG=Release
set PLATFORM=amd64
set VCPATH="C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build"

if not defined DevEnvDir (
    call %VCPATH%\vcvarsall.bat %PLATFORM%
)

:: Test NASM presence
where /Q nasm.exe
if errorlevel 1 (
    @echo on
    echo The application nasm is missing. Download it at https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win64/nasm-2.16.01-installer-x64.exe
    exit /b %errorlevel%
)

:: Test Perl presence
where /Q perl.exe
if errorlevel 1 (
    @echo on
    echo The application perl is missing. Download it at https://strawberryperl.com/
    exit /b %errorlevel%
)
set LC_ALL=C
set LANG=C
@echo on
echo ----------------------- download openssl -----------------------------
curl -L -o openssl-3.4.0.tar.gz https://github.com/openssl/openssl/releases/download/openssl-3.4.0/openssl-3.4.0.tar.gz
tar -xzf openssl-3.4.0.tar.gz
cd  openssl-3.4.0
call :NORMALIZEPATH "..\..\vendor\openssl"
set OPENSSL_INSTALL_DIR=%RETVAL%
if not exist %OPENSSL_INSTALL_DIR% (
    mkdir %OPENSSL_INSTALL_DIR%
)
@echo on
echo ----------------------- configure openssl build -----------------------
perl Configure VC-WIN64A --prefix="%OPENSSL_INSTALL_DIR%" --openssldir="%OPENSSL_INSTALL_DIR%"
echo ----------------------- build openssl  -----------------------
set CL=/MP
nmake
nmake install
echo clean
cd ..
rmdir /s /q openssl-3.4.0
del openssl-3.4.0.tar.gz
echo ----------------------- openssl build done -----------------------
exit /B


:NORMALIZEPATH
  SET RETVAL=%~f1
  EXIT /B