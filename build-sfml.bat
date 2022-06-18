@echo off
IF [%1] == [] (
	echo Please provide the path to your ndk
	exit /b
)

set ndk_path_valid=0
FOR %%i IN (%1) DO IF EXIST %%~si\NUL set ndk_path_valid=1

if [%ndk_path_valid%] NEQ [1] (
	echo The path you provided to your NDK is not a directory
	exit /b
)

CALL check-requirements.bat
IF ERRORLEVEL 1 exit /b

set ndk_path=%1

IF [%2] == [] set install_path=%userprofile%\SFML
IF [%2] NEQ [] (
    IF [%2] NEQ [--release] (
        set install_path=%2
    ) ELSE (
        set install_path=%userprofile%\SFML
    )
)
echo Downloading SFML to %install_path%

if not exist %install_path% md %install_path%
pushd %install_path%
git clone https://github.com/SFML/SFML

cd SFML
md build
cd build

set build_type=Debug

IF [%2] == [--release] set build_type=Release
IF [%3] == [--release] set build_type=Release

REM 64 bit abis (arm64-v8a and x86_64) currently fail due to not finding OpenAL, so they are not included
set abis=x86 armeabi-v7a
(for %%a in (%abis%) do ( 
   md %%a
   echo @echo off> %%a\rebuild-temp.txt
   echo set current_abi=%%a>> %%a\rebuild-temp.txt
   echo set ndk_path=%ndk_path%>> %%a\rebuild-temp.txt
   echo set build_type=%build_type%>> %%a\rebuild-temp.txt
))

popd
(for %%a in (%abis%) do ( 
   type %~dp0rebuild.bat >> %install_path%\SFML\build\%%a\rebuild-temp.txt
   type %install_path%\SFML\build\%%a\rebuild-temp.txt > %install_path%\SFML\build\%%a\rebuild.bat
   del %install_path%\SFML\build\%%a\rebuild-temp.txt
))

xcopy %~dp0rebuild-all.bat %install_path%\SFML\build\

%install_path%\SFML\build\rebuild-all.bat

