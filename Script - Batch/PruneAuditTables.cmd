@echo off

rem **********VARIABLES THAT NEED TO BE CHANGED**********

               rem path_to_WIPDS - the path to your WIP Data Server bin directory
               rem NOTE: This variable cannot contain spaces
               set path_to_WIPDS=D:\SAS\BIN\SASWebInfrastructurePlatformDataServer\9.4\bin

               rem                      dbPort - the port on which this SAS WIP Data Server listens
               rem                      dbUser - the user name for the SAS WIP Data Server
               set dbPort=9432
               set dbUser=SharedServices

               rem PGPASSWORD - the password for the dbUser account
               set PGPASSWORD=SharedServicesPHOTOWATT@2015
               
               rem                      OPTIONALLY MODIFY THESE
               rem                      auditAge - delete all audit entries older than this many days.
               rem                      archiveAge - delete all archived audit entries older than this.
               set auditAge=0
               set archiveAge=0

rem **********END OF VARIABLES THAT NEED TO BE CHANGED**********

rem                      tables to prune ....
set audTable=sas_audit
set entryTable=sas_audit_entry
set audArchive=sas_audit_archive
set entryArchive=sas_audit_entry_archive

rem This checks if the path_to_WIPDS variable was set correctly. If it was - jump to the beginExecution section, If it wasn't - print out error message and stop
if  exist %path_to_WIPDS%\psql.exe (goto beginExecution)

echo ------------------------- > con
echo ERROR: > con 
echo You have encountered an error. Most likely because you have not specifed the path to your WIP Data Server bin directory properly. Please close this window, edit that variable, and try again. > con
pause>nul

rem                      execute commands
:beginExecution
echo Pruning tables:
echo    user: %dbUser%
echo    port: %dbPort%
echo    this will *delete* audit records older than ............ %auditAge% days old
echo    this will *delete* archived audit records older than ... %archiveAge% days old
echo "    %entrytable% ........... "
%path_to_WIPDS%\psql -p %dbPort% -U %dbUser% -c "delete from %entryTable% a where a.audit_id in (select saa.audit_id from %audTable% saa where date_part('days',localtimestamp - timestamp_dttm) > %auditAge% );"
echo "    %entryArchive% ... "
%path_to_WIPDS%\psql -p %dbPort% -U %dbUser% -c "delete from %entryArchive% a where a.audit_id in (select saa.audit_id from %audArchive% saa where date_part('days',localtimestamp - timestamp_dttm) > %archiveAge% );"
echo "    %audtable% ................. "
%path_to_WIPDS%\psql -p %dbPort% -U %dbUser% -c "delete from %audTable% where date_part('days',localtimestamp - timestamp_dttm) > %auditAge% ;"
echo "    %audArchive% ......... "
%path_to_WIPDS%\psql -p %dbPort% -U %dbUser% -c "delete from %audArchive% where date_part('days',localtimestamp - timestamp_dttm) > %archiveAge% ;"

pause>nul
