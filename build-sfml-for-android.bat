@echo off
IF [%1] == [] (
	echo Please provide the path to your ndk
	exit /b
)

set ndk_path=D:/NVPACK/android-ndk-r19

IF [%2] == [] set install_path=%userprofile%\SFML
IF [%2] NEQ [] set install_path=%1
echo Downloading SFML to %install_path%

if not exist %install_path% md %install_path%
pushd %install_path%
git clone https://github.com/SFML/SFML

cd SFML
md build
cd build

set abis=x86 armeabi armeabi-v7a 
(for %%a in (%abis%) do ( 
   md %%a
   echo set current_abi=%%a> %%a\rebuild-temp.txt
   echo set ndk_path=%ndk_path%>> %%a\rebuild-temp.txt
))

popd
(for %%a in (%abis%) do ( 
   type rebuild.bat >> %install_path%\SFML\build\%%a\rebuild-temp.txt
   type %install_path%\SFML\build\%%a\rebuild-temp.txt > %install_path%\SFML\build\%%a\rebuild.bat
   del %install_path%\SFML\build\%%a\rebuild-temp.txt
))

