@echo off
REM /*-------------------------------\
REM | Run AutoLoad.sas               |
REM \-------------------------------*/

REM Define needed environment variables
call "D:\SAS\Config\Lev1\level_env.bat"

set SERVER_CONTEXT=SASApp
set APPSERVER_ROOT=%LEVEL_ROOT%\%SERVER_CONTEXT%
set AUTOLOAD_ROOT=D:\SAS\Config\Lev1\Applications\SASVisualAnalytics\VisualAnalyticsAdministrator

REM copy Landing area files in AUTOLOAD directory
call "D:\SAS\DATAMNGT\pgm\copy_landing_to_autoload.cmd"

set FILENAME="%AUTOLOAD_ROOT%\AutoLoad.sas"
set LOG_FILE="%AUTOLOAD_ROOT%\Logs\AutoLoad_#Y.#m.#d_#H.#M.#s.log"
set LST_FILE="%AUTOLOAD_ROOT%\Logs\AutoLoad.lst"
set CFG_FILE="%AUTOLOAD_ROOT%\AutoLoad.cfg"

cd "%APPSERVER_ROOT%"
call "%SAS_COMMAND%" -sysin %FILENAME% -config %CFG_FILE% -log %LOG_FILE% -print %LST_FILE% -batch -noterminal -nologo -logparm "rollover=session"

REM Return the appropriate exit code
exit %ERRORLEVEL%
