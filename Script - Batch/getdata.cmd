@echo on
setlocal EnableDelayedExpansion
cls
cd D:\SAS\Config\Lev1\SchedulingServer\RunNow_PWSASPROD
for /f "delims=" %%A in ('dir /b /s /A-D "*.log" ^| find /V "CUBE" ^| find /V "DAILY" ^| find /V "DATAMART" ^| find /V "ADHOC" ^| find /V "DELTA" ^| find /V "TEST"') do (
del /Q /S %%A
)
cd D:\SAS\Config\Lev1\SchedulingServer\RunNow_PWSASPROD
set MAXTIMEOUT=4
for /f "delims=" %%f in ('dir /b /s /A-D "*.vbs" ^| find /V "CUBE" ^| find /V "DAILY" ^| find /V "DATAMART" ^| find /V "ADHOC" ^| find /V "DELTA" ^| find /V "TEST"') do call :PROC %%f
goto :EOF

:PROC
set MAXTIMEOUT=4
set JOB=%1
:retry
echo !DATE! !TIME! START  !JOB! >> D:\SAS\DATAMNGT\logs\getdata.log
C:\Windows\system32\cscript.exe !JOB! //B //NoLogo
findstr "status=2" !JOB!\..\*.log
set FIND=!errorlevel!
echo FIND=!FIND!
if "!FIND!" == "0" (
echo !DATE! !TIME! END_KO !JOB! >> D:\SAS\DATAMNGT\logs\getdata.log
)
if "!FIND!" == "1" (
echo !DATE! !TIME! END_OK !JOB! >> D:\SAS\DATAMNGT\logs\getdata.log
)
set /a MAXTIMEOUT=MAXTIMEOUT-1
if "%MAXTIMEOUT%" == "0" (
echo !DATE! !TIME! SKIP   !JOB! >> D:\SAS\DATAMNGT\logs\getdata.log
goto skip
)
if "!FIND!" == "0" (
timeout 20
echo !DATE! !TIME! RETRY  !JOB! >> D:\SAS\DATAMNGT\logs\getdata.log
goto retry
)
:skip
goto :EOF

ENDLOCAL