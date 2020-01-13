@echo off

CALL check-requirements.bat
IF ERRORLEVEL 1 exit /b

set latest_ndk_version=20b
set android_zip_name=android-ndk-r%latest_ndk_version%-windows-x86_64.zip
IF [%1] == [] (
	set ndk_download_path=%~dp0
) ELSE (
	set ndk_download_path=%1
)
IF NOT "%ndk_download_path:~1,1%" == ":" (
	echo Relative paths cannot be used
	exit /b
)
IF NOT "%ndk_download_path:~-1%" == "\" (
	set ndk_download_path=%ndk_download_path%\
)

wget --directory-prefix %ndk_download_path% https://dl.google.com/android/repository/%android_zip_name%

Call :UnZipFile "%ndk_download_path%" "%ndk_download_path%android-ndk-r%latest_ndk_version%-windows-x86_64.zip"
del %ndk_download_path%%android_zip_name%

build-sfml.bat %ndk_download_path%android-ndk-r%latest_ndk_version%

exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
