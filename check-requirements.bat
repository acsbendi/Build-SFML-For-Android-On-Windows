@echo off

set requirements=cmake git

(for %%r in (%requirements%) do ( 
    	where %%r.exe >nul 2>nul
    	IF ERRORLEVEL 1 (
    		echo %%r.exe not found in path.
    		exit /b 3
	)
))



exit /b 0
