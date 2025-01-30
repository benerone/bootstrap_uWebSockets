@echo on
echo ----------------------- download uWebSockets v20.72.0 -----------------------------
curl -L -o uWebSockets.v20.72.0.zip https://github.com/uNetworking/uWebSockets/archive/refs/tags/v20.72.0.zip
:: tar -xf uWebSockets.v20.72.0.zip -C ./uWebSockets.v20.72.0
PowerShell -Command "Expand-Archive -Path 'uWebSockets.v20.72.0.zip' -Force"

if not exist "..\vendor\uWebSockets" mkdir "..\vendor\uWebSockets"
xcopy /E /I /Y "uWebSockets.v20.72.0\uWebSockets-20.72.0\src" "..\vendor\uWebSockets"
rmdir /S /Q "uWebSockets.v20.72.0"
del uWebSockets.v20.72.0.zip

echo ----------------------- download uSockets v20.72.0 -----------------------------
curl -L -o uSockets.v20.72.0.zip https://github.com/uNetworking/uSockets/archive/182b7e4fe7211f98682772be3df89c71dc4884fa.zip
:: tar -xf uSockets.v20.72.0.zip -C ./uSockets.v20.72.0
PowerShell -Command "Expand-Archive -Path 'uSockets.v20.72.0.zip' -Force"

if not exist "..\vendor\uSockets" mkdir "..\vendor\uSockets"
xcopy /E /I /Y "uSockets.v20.72.0\uSockets-182b7e4fe7211f98682772be3df89c71dc4884fa\src" "..\vendor\uSockets"
rmdir /S /Q "uSockets.v20.72.0"
del uSockets.v20.72.0.zip