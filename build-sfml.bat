@echo off
IF [%1] == [] (
	echo Please provide the path to your ndk
	exit /b
)

CALL check-requirements.bat
IF ERRORLEVEL 1 exit /b

set ndk_path=%1

IF [%2] == [] set install_path=%userprofile%\SFML
IF [%2] NEQ [] set install_path=%2
echo Downloading SFML to %install_path%

if not exist %install_path% md %install_path%
pushd %install_path%
git clone https://github.com/SFML/SFML

cd SFML
md build
cd build

REM 64 bit abis (arm64-v8a and x86_64) currently fail due to not finding OpenAL, so they are not included
set abis=x86 armeabi-v7a
(for %%a in (%abis%) do ( 
   md %%a
   echo @echo off> %%a\rebuild-temp.txt
   echo set current_abi=%%a>> %%a\rebuild-temp.txt
   echo set ndk_path=%ndk_path%>> %%a\rebuild-temp.txt
))

popd
(for %%a in (%abis%) do ( 
   type %~dp0rebuild.bat >> %install_path%\SFML\build\%%a\rebuild-temp.txt
   type %install_path%\SFML\build\%%a\rebuild-temp.txt > %install_path%\SFML\build\%%a\rebuild.bat
   del %install_path%\SFML\build\%%a\rebuild-temp.txt
))

xcopy %~dp0rebuild-all.bat %install_path%\SFML\build\

%install_path%\SFML\build\rebuild-all.bat

