@echo on
setlocal EnableDelayedExpansion
cls
D:\
del /Q /S D:\SAS\Config\Lev1\SchedulingServer\RunNow_PWSASPROD\*DATAMART*.log
cd D:\SAS\Config\Lev1\SchedulingServer\RunNow_PWSASPROD
set MAXTIMEOUT=4
for /f "delims=" %%f in ('dir /b /s /A-D *DATAMART*.vbs') do call :PROC %%f
goto :EOF

:PROC
set MAXTIMEOUT=4
set JOB=%1
:retry
echo !DATE! !TIME! START  !JOB! >> D:\SAS\DATAMNGT\logs\getdata_datamart.log
C:\Windows\system32\cscript.exe !JOB! //B //NoLogo
findstr "status=2" !JOB!\..\*.log
set FIND=!errorlevel!
echo FIND=!FIND!
if "!FIND!" == "0" (
echo !DATE! !TIME! END_KO !JOB! >> D:\SAS\DATAMNGT\logs\getdata_datamart.log
)
if "!FIND!" == "1" (
echo !DATE! !TIME! END_OK !JOB! >> D:\SAS\DATAMNGT\logs\getdata_datamart.log
)
set /a MAXTIMEOUT=MAXTIMEOUT-1
if "%MAXTIMEOUT%" == "0" (
echo !DATE! !TIME! SKIP   !JOB! >> D:\SAS\DATAMNGT\logs\getdata_datamart.log
goto skip
)
if "!FIND!" == "0" (
timeout 20
echo !DATE! !TIME! RETRY  !JOB! >> D:\SAS\DATAMNGT\logs\getdata_datamart.log
goto retry
)
:skip
goto :EOF

ENDLOCAL