:: Build zlib based on https://developers.lseg.com/en/article-catalog/article/how-to-build-openssl--zlib--and-curl-libraries-on-windows
@echo off
::set CONFIG=Release
set PLATFORM=amd64
set VCPATH="C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build"

if not defined DevEnvDir (
    call %VCPATH%\vcvarsall.bat %PLATFORM%
)

@echo on
echo ----------------------- download zlib -----------------------------
curl -L -o zlib-1.3.1.tar.gz https://zlib.net/zlib-1.3.1.tar.gz
tar -xzf zlib-1.3.1.tar.gz
del zlib-1.3.1.tar.gz
::@echo off
cd zlib-1.3.1
call :NORMALIZEPATH "..\..\vendor\zlib"
set ZLIB_INSTALL_DIR=%RETVAL%
if not exist %ZLIB_INSTALL_DIR% (
    mkdir %ZLIB_INSTALL_DIR%
    mkdir %ZLIB_INSTALL_DIR%\bin
    mkdir %ZLIB_INSTALL_DIR%\include
)
@echo on
set CL=/MP
nmake /f win32/Makefile.msc
copy *.exe %ZLIB_INSTALL_DIR%\bin\
copy *.dll %ZLIB_INSTALL_DIR%\bin\
copy *.h %ZLIB_INSTALL_DIR%\include\
copy *.lib %ZLIB_INSTALL_DIR%\bin\
echo ----------------------- zlib build done -----------------------
cd ..
rmdir /s /q  zlib-1.3.1
exit /B


:NORMALIZEPATH
  SET RETVAL=%~f1
  EXIT /B