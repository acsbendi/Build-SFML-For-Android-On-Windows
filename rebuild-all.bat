@echo off
REM 64 bit abis (arm64-v8a and x86_64) currently fail due to not finding OpenAL, so they are not included
set abis=x86 armeabi-v7a
(for %%a in (%abis%) do ( 
   pushd %~dp0%%a
   start rebuild.bat
   popd
))
