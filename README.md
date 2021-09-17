﻿# Build SFML For Android On Windows
Batch scripts to build SFML for Android, using the latest Android NDK

# Requirements

Successfully building SFML requires that you have the following in your `PATH`:
* `cmake` (minimum version is **3.7.2**)
* `git`
* the directory where MinGW is installed (for example, `C:\Program Files\mingw32\bin`). You can check this by trying to run `mingw32-make` in CMD.

# How to use it

### ● If you have NDK installed:

Run `build-sfml.bat` followed by the **absolute** path to your NDK. For example, if your NDK is located at D:\NVPACK\android-ndk-r19, then you have to run `build-sfml.bat D:\NVPACK\android-ndk-r19`.
        
### ● If you don't have NDK installed:

You can install the newest version before building SFML, by executing `download-ndk-and-build-sfml.bat`. You can also specify where to install ndk, by providing an **absolute** path to the script. For example, if you want to install it in D:\Android, then you should run `download-ndk-and-build-sfml.bat D:\Android`. After downloading the NDK, this script will also run `build-sfml.bat` and thus build SFML.

## Path to the downloaded SFML repository

The script will download SFML to %userprofile%\SFML. For example, if your username is Foo, you will be able to find the downloaded SFML repository at C:\Users\Foo\SFML.

## Created scripts

The following scripts are created in %userprofile%\SFML\build and its subdirectories. They are also run by `build-sfml.bat` when it builds SFML for the first time. You can use them to rebuild SFML in case you modify something in it.

#### ● `rebuild-all.bat`: 
Rebuilds SFML for all ABIs.

#### ● `rebuild.bat` (in each ABI's directory): 
Rebuilds SFML for the ABI corresponding to script's directory.


