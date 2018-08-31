/* Internal settings */
%LET AL_PRODNAME=LASR Auto Load;
%LET AL_PRODNAME_SHORT=AutoLoad;
%LET AL_PRODVERS=7.2;

/* Scan Tables */
%LET ROOTFLLIST=WORK.SCANADDF;
%LET APNDFLLIST=WORK.SCANAPDF;
%LET UNLDFLLIST=WORK.SCANUNLF;

%LET ROOTTBLIST=WORK.SCANADDT;
%LET APNDTBLIST=WORK.SCANAPDT;
%LET UNLDTBLIST=WORK.SCANUNLT;
%LET ROSTBLLIST=WORK.SCANROSTBLS;
%LET ROSLIBLIST=WORK.SCANROSLIBS;

%LET LASRTBLIST=WORK.SCANLASR;

/* Sync Tables */
%LET IMPLIST=WORK.SYNCIMP;
%LET ADDLIST=WORK.SYNCADD;
%LET UPDLIST=WORK.SYNCUPD;
%LET APNLIST=WORK.SYNCAPD;
%LET UNLLIST=WORK.SYNCUNL;
%LET UNKLIST=WORK.SYNCOTH;
%LET ROSLIST=WORK.SYNCROSTBLS;
%LET ROSLIBS=WORK.SYNCROSLIBS;

/* Extended Attribute Keys */
%LET EXT_KEY_ENABLED			=VA.AutoLoad.Enabled;
%LET EXT_KEY_AUTOSTART			=VA.AutoLoad.AutoStart;
%LET EXT_KEY_METAFOLDER			=VA.Default.MetadataFolder;
%LET EXT_KEY_FILEFOLDER 		=VA.AutoLoad.Location;
%LET EXT_KEY_SYNC_ENABLED		=VA.AutoLoad.Sync.Enabled;
%LET EXT_KEY_SYNC_IMPORT		=VA.AutoLoad.Sync.Import;
%LET EXT_KEY_SYNC_LOAD			=VA.AutoLoad.Sync.Load;
%LET EXT_KEY_SYNC_REFRESH		=VA.AutoLoad.Sync.Refresh;
%LET EXT_KEY_SYNC_APPEND		=VA.AutoLoad.Sync.Append;
%LET EXT_KEY_SYNC_UNLOAD		=VA.AutoLoad.Sync.Unload;
%LET EXT_KEY_COMPRESS_ENABLED	=VA.AutoLoad.Compress.Enabled;
%LET EXT_KEY_EXPANDCHARS_ENABLED=VA.AutoLoad.ExpandChars.Enabled;
%LET EXT_KEY_IMPORT_DLM_TXT		=VA.AutoLoad.Import.Delimiter.TXT;
%LET EXT_KEY_IMPORT_ROWSTOSCAN	=VA.AutoLoad.Import.RowsToScan;
%LET EXT_KEY_ROS_ENABLED		=VA.ReloadOnStart.Enabled;
%LET EXT_KEY_ROS_TBLDEFAULT		=VA.ReloadOnStart.TableDefault;
%LET EXT_KEY_ROS_METHOD 		=VA.ReloadOnStart.Method;
%LET EXT_KEY_DEBUG_ENABLED		=VA.AutoLoad.Debug.Enabled;
%LET EXT_KEY_MON_PATH			=VA.MonitoringPath;
%LET EXT_KEY_TABLE_FULLCOPIES	=VA.TableFullCopies;

/* Software Component Keys */
%LET SC_CLASSID_COMMON      =vacommon;
%LET SC_KEY_MONITORING_PATH =va.monitoringPath;

/* Include other used modules */
%include inclib (
	Utility.sas
	Messages.sas
	MetadataExtensions.sas
	DataSetVarsToMacroVars.sas
	LASRLibraryMetadataToDataSet.sas
	LASRServerRunning.sas
	StartLASRServer.sas
	StopLASRServer.sas
	GetFilesListFromFolder.sas
	GetTablesListFromLibrary.sas
	GetMetadataTablesList.sas
	FilterReloadOnStart.sas
	GetLASRServerLibrariesList.sas
	AssignLASRLibrary.sas
	BuildSyncTables.sas
	AppendTable.sas
	LoadTableToLASR.sas
	ActionSummaryPreview.sas
	RegisterTable.sas
	Logging.sas
	ValidateAutoLoadFolderStructure.sas
	ImportExcel.sas
	ImportDLM.sas
	NormalizeSASNamesInDataSet.sas
	SetSASOptions.sas
	); 

%include inclibim (
	IMLoadTableToLASR.sas
	);
	

/* Main Body Code */
%macro IMAutoLoadMain;

	/* Set SAS options */
	options validvarname=ANY
			validmemname=EXTEND;
	%SetOSSlash;

	/* Validate folder structure */
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_FILEFOLDER., 	Retvar=AL_AUTOLOAD_DIR );
	%ValidateAutoLoadFolderStructure(&AL_AUTOLOAD_DIR.);
	%IF ( &LASTSTEPRC. ne 0 ) %THEN %DO;
		%msg( type=ERROR, msg=%str(&AL_PRODNAME. directory validation failed.));
		%msg( type=ERROR, msg=%str(Ensure that connection to metadata server is configured properly));
		%msg( type=ERROR, msg=%str(and that the proper autoload folder structure exists.));
		%return;
	%END;

	/* Setup globals */
	%global AL_OPTION_ROS_ENABLED;

	/* Load software component values */
	%global AL_MONITORING_PATH;
	%GetSoftwareComponentKeyValue( ClassId=&SC_CLASSID_COMMON., Key=&SC_KEY_MONITORING_PATH., RetVar=AL_MONITORING_PATH);
	%if (%nrbquote(&AL_MONITORING_PATH.) eq MISSING) %then %symdel AL_MONITORING_PATH;

	/* Set up logging library and process ID File */
	%global AL_AUTOLOAD_LOGS_DIR;
	%let AL_AUTOLOAD_LOGS_DIR=&AL_AUTOLOAD_DIR.&OSSLASH.Logs;

	%if ^%symexist(TASKNAME) %then %let TASKNAME=AUTOLOAD;
	%if ^%symexist(PIDFILE) %then %do;
		%let PIDNAME=%qcmpres(&AL_META_LASRLIB.);
		%NormalizeStringForFilename(PIDNAME);
		%let PIDNAME=%QKTRIM(&PIDNAME.);
		%let PIDNAME=%klowcase(&TASKNAME.)_&PIDNAME..pid;
		%if ^%symexist(AL_MONITORING_PATH) %then %let PIDFILE=&AL_AUTOLOAD_LOGS_DIR.&OSSLASH.&PIDNAME.;
		%else									 %let PIDFILE=&AL_MONITORING_PATH.&OSSLASH.PIDs&OSSLASH.&PIDNAME.;
	%end;

	%LET AL_LOGDATASET=DBLOG.&TASKNAME.;
	%LET AL_LOGDATASET=%SYSFUNC(ktranslate(&AL_LOGDATASET.,"_","-"));
	%LET AL_DEBUG_FILE=&AL_AUTOLOAD_LOGS_DIR.&OSSLASH.%klowcase(&TASKNAME.).dbg;
	%CreateProcessIDFile(&PIDFILE.);
	libname dblog base "&AL_AUTOLOAD_LOGS_DIR.";

	%msg( msg=%str(&AL_PRODNAME. &AL_PRODVERS.) );
	%msg( msg=%str(Task Name: &TASKNAME.) );
	%msg( msg=%str(Process ID: &SYSJOBID.) );
	%msg( msg=%str(Configuration Settings:) );

	%global AL_METAREPOSITORY;
	%let AL_METAREPOSITORY=%SYSFUNC(getoption(METAREPOSITORY));

	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_ENABLED., Retvar=AL_META_ENABLED );
	%IF (%NOTYES(AL_META_ENABLED)) %THEN %DO;
		%msg( msg=%str(METASERVER=%SYSFUNC(getoption(METASERVER))));
		%msg( msg=%str(METAPORT=%SYSFUNC(getoption(METAPORT))));
		%msg( msg=%str(METAREPOSITORY=%SYSFUNC(getoption(METAREPOSITORY))));
		%msg( msg=%str(METAUSER=%SYSFUNC(getoption(METAUSER))));
		%msg( msg=%str(METAPASS=%SYSFUNC(getoption(METAPASS))));
		%msg( msg=%str(LIBRARY=&AL_META_LASRLIB.));
		%msg( type=ERROR, msg=%str(&AL_PRODNAME. either cannot find &AL_META_LASRLIB. library, or the library is not enabled for auto load.));
		%msg( type=ERROR, msg=%str(Check the following:));
		%msg( type=ERROR, msg=%str(1- Ensure metadata server, port, and repository are set correctly));
		%msg( type=ERROR, msg=%str(2- Ensure metadata user and metadata password are set correctly));
		%msg( type=ERROR, msg=%str(3- Ensure library exists, has a unique name, and has &EXT_KEY_ENABLED. extended attribute set to "Yes".));
		%return;
	%END;

	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_METAFOLDER., 		Retvar=AL_META_TRG_FOLDER );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_AUTOSTART., 		Retvar=AL_OPTION_AUTOSTART );

	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_SYNC_ENABLED.,		Retvar=AL_OPTION_SYNC_ENABLED );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_SYNC_IMPORT., 		Retvar=AL_OPTION_SYNC_IMPORT );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_SYNC_LOAD., 		Retvar=AL_OPTION_SYNC_LOAD );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_SYNC_UNLOAD., 		Retvar=AL_OPTION_SYNC_UNLOAD );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_SYNC_REFRESH.,		Retvar=AL_OPTION_SYNC_REFRESH );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_SYNC_APPEND., 		Retvar=AL_OPTION_SYNC_APPEND );

	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_COMPRESS_ENABLED., Retvar=AL_OPTION_COMPRESS_ENABLED );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_EXPANDCHARS_ENABLED., Retvar=AL_OPTION_EXPANDCHARS_ENABLED );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_IMPORT_DLM_TXT., 	Retvar=AL_OPTION_IMPORT_DLM_TXT );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_IMPORT_ROWSTOSCAN., Retvar=AL_OPTION_IMPORT_ROWSTOSCAN );
	%MetadataExtensionValue( Type=SASLibrary, Name=%str(&AL_META_LASRLIB.), Key=&EXT_KEY_DEBUG_ENABLED.,	Retvar=AL_OPTION_DEBUG_ENABLED );

	/* Load configuration */
	%msg( msg=%str(Loading library attributes...));
	%LASRLibraryMetadataToDataSet(data=work.lasrlib, name=&AL_META_LASRLIB.);
	%DataSetVarsToMacroVars(data=work.lasrlib, prefix=AL_);

	%IF ( "&AL_LASRMONPATH." ne "" ) %THEN
		%LET AL_MONITORING_PATH=&AL_LASRMONPATH.;

	/* If debug is enabled, then set up debug of SAS statements */
	%IF ( %IsYes(AL_OPTION_DEBUG_ENABLED) ) %THEN %DO;
		%msg( msg=%str(Debug Mode Enabled));
		filename mprint "&AL_DEBUG_FILE.";
		%setoption(on,mprint);
		%setoption(on,mfile);
	%END;
	%ELSE %DO;
		%setoption(off,mprint);
		%setoption(off,mfile);
	%END;

	%LET FULLCOPYTO=;
	%IF ( %LENGTH(&AL_TABLEFULLCOPIES.) ne 0) %THEN
		%LET FULLCOPYTO=%str(fullcopyto=%KTRIM(&AL_TABLEFULLCOPIES.));

	/* Make sure the LASR server is running and accessible */
	%msg( msg=%str(Connecting to LASR server %ktrim(&AL_LASRHOST.):%ktrim(&AL_LASRPORT.)));
	%msg( msg=%str(If the server is not running, an ERROR could appear here.));
	%LASRSERVERRUNNING(HOST=&AL_LASRHOST., PORT=&AL_LASRPORT., SIGNER=&AL_SIGNER., TAG=&AL_LIBTAG.);
	%if ( &LASRRUNNING. ) %then %do;
	   %LET AL_OPTION_ROS_ENABLED=NO;
	   %msg( msg=%str(LASR server %ktrim(&AL_LASRHOST.):%ktrim(&AL_LASRPORT.) is running) );
	%end;
	%else %DO;
		%IF ( %ISYES(AL_OPTION_AUTOSTART) ) %THEN %DO;
			%msg( msg=%str(LASR server %ktrim(&AL_LASRHOST.):%ktrim(&AL_LASRPORT.) is not running.), LEVEL=ERROR);
			%if (&AL_SMP. eq 1) %THEN 	%LET SRVTYP=SMP;
			%else 						%LET SRVTYP=MPP;

			%STARTLASRSERVER	( TYPE=&SRVTYP., HOST=&AL_LASRHOST., PORT=&AL_LASRPORT., INST=&AL_LASRINST., SIGNER=&AL_SIGNER.
								, PATH=&AL_PATH.,NODES=&AL_NODES.,FORCE=&AL_FORCE.,VERBOSE=&AL_SERVERVERBOSE.,LIFETIME=&AL_LIFETIME.
								, TABLEMEM=&AL_TABLEMEM.,EXTERNALMEM=&AL_EXTERNALMEM.
								, LOGGING=&AL_LOGGINGENABLED., LOGGINGPATH=&AL_LOGGINGPATH., MAXFILESIZE=&AL_LOGGINGMAXFILESIZE.
								, MAXROLLNUM=&AL_LOGGINGMAXROLLOVER., KEEPLOG=&AL_LOGGINGKEEPLOG., LOGADDITIONAL=&AL_LOGGINGADDITIONAL.
								);

			%LASRSERVERRUNNING(HOST=&AL_LASRHOST., PORT=&AL_LASRPORT., SIGNER=&AL_SIGNER., TAG=&AL_LIBTAG.);
			%if ( "&LASRRUNNING." ne "1" ) %then %DO;
				%msg( type=ERROR, msg=%str(Could not start LASR server.  Processing cancelled.), LEVEL=ERROR);
				%return;
			%END;
			%LET AL_OPTION_ROS_ENABLED=YES;
		%END;
		%ELSE %DO;
			%msg( TYPE=ERROR, msg=%str(LASR server is not running.  Processing cancelled.), LEVEL=ERROR);
			%msg( TYPE=ERROR, msg=%str(Either set &EXT_KEY_AUTOSTART. to 'Yes', or manually start the LASR server.), LEVEL=ERROR);
			%return;
		%END;
	%END;

	/* LASR server is running.  Load source folder content */
	%msg( msg=%str(Examining %ktrim(&AL_AUTOLOAD_DIR.) content));

	/* Assign source libraries */
	%LET AL_AUTOLOAD_FORMATS_DIR=&AL_AUTOLOAD_DIR.&OSSLASH.Formats;
	%LET AL_AUTOLOAD_APPEND_DIR=&AL_AUTOLOAD_DIR.&OSSLASH.Append;
	%LET AL_AUTOLOAD_UNLOAD_DIR=&AL_AUTOLOAD_DIR.&OSSLASH.Unload;

	%LET CVPOPTS=;
	%IF (%ISYES(AL_OPTION_EXPANDCHARS_ENABLED)) %THEN %DO;
		%LET CVP=cvp;
		%LET CVPOPTS=%str(CVPMULTIPLIER=2);
	%END;
	%ELSE 												
		%LET CVP=base;

	libname db &CVP. "&AL_AUTOLOAD_DIR." &CVPOPTS.;
	libname dbout base "&AL_AUTOLOAD_DIR.";
	libname dbappend &CVP. "&AL_AUTOLOAD_APPEND_DIR." &CVPOPTS.;
	libname dbappout base "&AL_AUTOLOAD_APPEND_DIR.";
	libname dbunload base "&AL_AUTOLOAD_UNLOAD_DIR.";
	%IF ( %SYSFUNC(FILEEXIST("&AL_AUTOLOAD_FORMATS_DIR.")) eq 1 ) %THEN %DO;
		libname dbformat base "&AL_AUTOLOAD_FORMATS_DIR.";
	%END;

	/* Set SAS Options */
	%SetSASOptions;

	/* Build sync tables */
	%BuildSyncTables;

	/* If there are no files to synchronize, abort further processing */
   	%IF (&AL_FILESTOSYNC. eq 0) %THEN %DO;
		%TIMESTAMP( %str(NOTE: No files or tables to process.), SHOW=YES );
		%TIMESTAMP( %str(NOTE: No actions will be performed.), SHOW=YES );
		%RETURN;
	%END;

	/* Output summary */
	%OutputSummary;
	%put %str(--------------------------------------------------------);

	/* If synchronization is not enabled, abort further processing */
	%IF (%NOTYES(AL_OPTION_SYNC_ENABLED)) %THEN %DO;
		%TIMESTAMP( %str(NOTE: &EXT_KEY_SYNC_ENABLED. option is set to &AL_OPTION_SYNC_ENABLED..), SHOW=YES );
		%TIMESTAMP( %str(NOTE: No actions will be performed.), SHOW=YES );
		%return;
	%END;

	%setoption(off, syntaxcheck);
	/*---------------------------------------------------------------------------------*/

	/* IMPORT ACTION */
	/* For each importable file, import to data set if data set not already present */
    /* If data set is present, only import if newer */

	%IF (%ISYES(AL_OPTION_SYNC_IMPORT)) %THEN %DO;
		/* Cycle through files to import */
		%IF %SYMEXIST(IMPFILES) %THEN %DO; %SYMDEL IMPFILES; %END;
		options nonotes;
		proc sql noprint;
		   select fullpath, _normalname, extension, outlib
			into 
			:IMPFILES 	separated by '`', 
			:IMPNAMES 	separated by '`',
			:IMPEXTS  	separated by '|',
			:IMPOUTLIBS separated by '|'
			from &IMPLIST. 
			;
		quit;
		options notes;

		%if %SYMEXIST(IMPFILES) and %SYMEXIST(IMPNAMES) %THEN %DO;
			%put NOTE: SCANNING %nrbquote(&IMPFILES.);
			%let pos=1;
			%let FIL=%QSCAN(%nrbquote(&IMPFILES.),&pos.,`);
			%let NAM=%QSCAN(%nrbquote(&IMPNAMES.),&pos.,`);
			%let EXT=%QSCAN(%nrbquote(&IMPEXTS.),&pos.,|);
			%let LIB=%SCAN(%nrbquote(&IMPOUTLIBS.),&pos.,|);
		   	%DO %WHILE ("%nrbquote(&FIL.)" ne "");
				%let FIL=%qktrim(&FIL.);
				%let NAM=%qktrim(&NAM.);
				%let EXT=%kupcase(&EXT.);

				%if ( &EXT. eq XLS or &EXT. eq XLSX or &EXT. eq XLSB or &EXT. eq XLSM ) %then %do;
					%PUT ---------------------------------------------------;
					%TIMESTAMP( %nrbquote(IMPORTING EXCEL FILE &NAM.), SHOW=YES, LEVEL=ACTION );
					%PUT ---------------------------------------------------;
					%msg(msg=%str(IMPORT TO DATA SET));
					%put &NAM.;
					%ImportExcel( excel=%NRBQUOTE(&FIL.)
								, table=&NAM.
								, libref=&LIB.
						%if ( &EXT. eq XLSB ) %then %do;
								, additionalopts=%str(MIXED=YES; SCANTEXT=YES; USEDATE=YES; SCANTIME=YES;)
						%end;
								); 
				%end;
				%else %if ( &EXT. eq CSV or &EXT. eq TSV or &EXT. eq TAB or &EXT. eq TXT) %then %do;
					%PUT ---------------------------------------------------;
					%TIMESTAMP( %nrbquote(IMPORTING DELIMITED FILE &NAM.), SHOW=YES, LEVEL=ACTION );
					%PUT ---------------------------------------------------;
					%msg(msg=%str(IMPORT TO DATA SET));
					%ImportDLM	( dlm=%NRBQUOTE(&FIL.)
								, table=&NAM.
								, libref=&LIB.
						%if ((&AL_OPTION_IMPORT_ROWSTOSCAN. ne MISSING) and (X&AL_OPTION_IMPORT_ROWSTOSCAN. ne X)) %then %do;
								, guessrows=&AL_OPTION_IMPORT_ROWSTOSCAN.
						%end;
						%else %do;
						%end;
						%if ( &EXT. eq TXT ) %then %do;
								, delim=%NRBQUOTE(&AL_OPTION_IMPORT_DLM_TXT.)
						%end;
								);  
				%end;

				%if (&SYSERR. gt 4) %then %DumpError;

				%let POS=%eval(&pos.+1);
				%let FIL=%QSCAN(%nrbquote(&IMPFILES.),&pos.,`);
				%let NAM=%QSCAN(%nrbquote(&IMPNAMES.),&pos.,`);
				%let EXT=%QSCAN(%nrbquote(&IMPEXTS.),&pos.,|);
				%let LIB=%SCAN(%nrbquote(&IMPOUTLIBS.),&pos.,|);
			%END;
		%END;

		/* Re-build sync tables to pick up any imported files' data sets */
		%BuildSyncTables;

	%END; /* IMPORT ENABLED */

	/* LOAD ACTION */
	/* For each table, load to LASR if not already in loaded tables list */
    /* If in loaded tables list, only load if newer */

	%IF (%ISYES(AL_OPTION_SYNC_LOAD)) %THEN %DO;
		/* Cycle through tables to add */
		%IF %SYMEXIST(ADDTABLES) %THEN %DO; %SYMDEL ADDTABLES; %END;
		options nonotes;
		proc sql noprint;
		   select fullref
			into :ADDTABLES separated by '|'
			from &ADDLIST. 
			;
		quit;
		options notes;
		%if %SYMEXIST(ADDTABLES) %THEN %DO;
			%put NOTE: SCANNING %nrbquote(&ADDTABLES.);
			%let pos=1;
			%let TBL=%QSCAN(%nrbquote(&ADDTABLES.),&pos.,|);
		   	%DO %WHILE ("%nrbquote(&TBL.)" ne "");

				%IF (%ISYES(AL_OPTION_COMPRESS_ENABLED)) %THEN 	%LET SQZ=YES;
				%ELSE 											%LET SQZ=NO;

				%PUT ---------------------------------------------------;
				%TIMESTAMP( %nrbquote(LOADING &TBL. (SQUEEZE=&SQZ.) TO LASR), SHOW=YES, LEVEL=ACTION );
				%PUT ---------------------------------------------------;
				%msg(msg=%str(LOAD TO LASR));
				%IMLoadTableToLASR	( refresh=No
				                    , data=%NRBQUOTE(&TBL.)
									, libref=&AL_LIBREF.
									, dsopts=%str(squeeze=&SQZ. &FULLCOPYTO.)
									); 
				%if (&SYSERR. le 4) %then %do;
					%msg(msg=%str(SYNCHRONIZE METADATA));
					%let CURRTBL=%SplitLibTable(data=%NRBQUOTE(&TBL.));
					%RegisterTable	( REPOSITORY=%nrbquote(&AL_METAREPOSITORY.)
									, LIBRARY=%nrbquote(&AL_LIBNAME.)
									, TABLE=%nrbquote(&CURRTBL.)
									, FOLDER=%nrbquote(&AL_META_TRG_FOLDER.)
									);
				%end;
				%else %DumpError;

				%if (&SYSERR. gt 4) %then %DumpError;

				%let POS=%eval(&pos.+1);
				%let TBL=%QSCAN(%nrbquote(&ADDTABLES.),&pos.,|);
			%END;
		%END;
	%END; /* LOAD ENABLED */

	/* REFRESH ACTION */
	/* For tables that already exist, but are older, refresh them by deleting */
	/* Existing table and re-adding */
	%IF (%ISYES(AL_OPTION_SYNC_REFRESH)) %THEN %DO;
		/* Cycle through tables to refresh */
		%IF %SYMEXIST(UPDTABLES) %THEN %DO; %SYMDEL UPDTABLES; %END;
		options nonotes;
		proc sql noprint;
		   select fullref
			into :UPDTABLES separated by '|'
			from &UPDLIST. 
			;
		quit;
		options notes;

		%if %SYMEXIST(UPDTABLES) %THEN %DO;
			%put NOTE: SCANNING %nrbquote(&UPDTABLES.);
			%let pos=1;
			%let TBL=%QSCAN(%nrbquote(&UPDTABLES.),&pos.,|);
		   	%DO %WHILE ("%nrbquote(&TBL.)" ne ""); 

				%IF (%ISYES(AL_OPTION_COMPRESS_ENABLED)) %THEN 	%LET SQZ=YES;
				%ELSE 											%LET SQZ=NO;

				%PUT ---------------------------------------------------;
				%TIMESTAMP( %nrbquote(REFRESHING &TBL. (SQUEEZE=&SQZ.) IN LASR), SHOW=YES, LEVEL=ACTION );
				%PUT ---------------------------------------------------;
				%LET TBLONLY=%SplitLibTable(data=%nrbquote(&TBL.),part=TABLE);

				%msg(msg=%str(REMOVE FROM LASR));
				/*%DeleteDataSetIfExists( data=%KTRIM(&AL_LIBREF.).%nrbquote(&TBLONLY.));*/
			
				%if (&SYSERR. le 4) %then %do;
					%msg(msg=%str(LOAD TO LASR));
					%IMLoadTableToLASR	( refresh=Yes
					                    , data=%nrbquote(&TBL.)
										, libref=&AL_LIBREF.
										, dsopts=%str(squeeze=&SQZ. &FULLCOPYTO.)
										); 
				%end;
				%else %DumpError;

				%if (&SYSERR. le 4) %then %do;
					%msg(msg=%str(SYNCHRONIZE METADATA));
					%let CURRTBL=%SplitLibTable(data=%NRBQUOTE(&TBL.));
					%RegisterTable	( REPOSITORY=%nrbquote(&AL_METAREPOSITORY.)
									, LIBRARY=%nrbquote(&AL_LIBNAME.)
									, TABLE=%nrbquote(&CURRTBL.)
									, FOLDER=%nrbquote(&AL_META_TRG_FOLDER.)
									);
					/* update table label */
					%GetDateTimeString(var=DTSTRING);

data _null_;
length liburi desc name $200 nlibobj librc rc 8;
nlibobj=1;
librc=metadata_getnobj("omsobj:PhysicalTable?@Id contains '.'",nlibobj,liburi);
do while (librc>0);
rc=metadata_getattr(liburi,'Name',name);
if name eq "%nrbquote(&CURRTBL.)" then do;
rc=metadata_getattr(liburi,"Desc",desc);
if index(desc,"Auto loaded")=1 then do;
rc=metadata_setattr(liburi,"Desc","Auto loaded &DTSTRING");
end;
end;
nlibobj+1;
librc=metadata_getnobj("omsobj:PhysicalTable?@Id contains '.'",nlibobj,liburi);
end;
run;

				%end;
				%else %DumpError;

				%if (&SYSERR. gt 4) %then %DumpError;

				%let POS=%eval(&pos.+1);
				%let TBL=%QSCAN(%nrbquote(&UPDTABLES.),&pos.,|);
			%END;
		%END;
	%END;

	/* APPEND ACTION */
	/* For tables that already exist, add additional rows using append */
	%IF (%ISYES(AL_OPTION_SYNC_APPEND)) %THEN %DO;
		/* Cycle through tables to refresh */
		%IF %SYMEXIST(APDTABLES) %THEN %DO; %SYMDEL APDTABLES; %END;
		options nonotes;
		proc sql noprint;
		   select fullref
			into :APDTABLES separated by '|'
			from &APNLIST. 
			;
		quit;
		options notes;

		%if %SYMEXIST(APDTABLES) %THEN %DO;
			%put NOTE: SCANNING %nrbquote(&APDTABLES.);
			%let pos=1;
			%let TBL=%QSCAN(%nrbquote(&APDTABLES.),&pos.,|);
		   	%DO %WHILE ("%nrbquote(&TBL.)" ne ""); 

				%IF (%ISYES(AL_OPTION_COMPRESS_ENABLED)) %THEN 	%LET SQZ=YES;
				%ELSE 											%LET SQZ=NO;

				%PUT ---------------------------------------------------;
				%TIMESTAMP( %nrbquote(APPENDING &TBL. (SQUEEZE=&SQZ.) IN LASR), SHOW=YES, LEVEL=ACTION );
				%PUT ---------------------------------------------------;

				/* Append these records to LASR AutoLoad folder for future loads */
				%if (&SYSERR. le 4) %then %do;
					%msg(msg=%str(APPEND IN AUTOLOAD ROOT DIRECTORY));
					%LET TBLONLY=%SplitLibTable(data=%nrbquote(&TBL.),part=TABLE);
					%AppendTable( base=%nrbquote(DB.&TBLONLY.)
								, data=%nrbquote(&TBL.)
								, out=%nrbquote(DBOUT.&TBLONLY.)
								);
				%end;
				%else %DumpError;

				/* Append to LASR */
				%if (&SYSERR. le 4) %then %do;

					%msg(msg=%str(LOAD TO LASR));
					%LoadTableToLASR	( data=%nrbquote(&TBL.)
										, libref=&AL_LIBREF.
										, dsopts=%str(append squeeze=&SQZ.)
										); 
				%end;
				%else %DumpError;

				/* Update table registration */
				%if (&SYSERR. le 4) %then %do;

					%msg(msg=%str(SYNCHRONIZE METADATA));
					%let CURRTBL=%SplitLibTable(data=%NRBQUOTE(&TBL.));
					%RegisterTable	( REPOSITORY=%nrbquote(&AL_METAREPOSITORY.)
									, LIBRARY=%nrbquote(&AL_LIBNAME.)
									, TABLE=%nrbquote(&CURRTBL.)
									, FOLDER=%nrbquote(&AL_META_TRG_FOLDER.)
									);
				%end;
				%else %DumpError;

				%if (&SYSERR. gt 4) %then %DumpError;

				%let POS=%eval(&pos.+1);
				%let TBL=%QSCAN(%nrbquote(&APDTABLES.),&pos.,|);
			%END;
		%END;
	%END;

	/* UNLOAD ACTION */
	/* For each table loaded to LASR, if a corresponding file with the same name exists in unload folder */
	/* unload the table. */

	%IF (%ISYES(AL_OPTION_SYNC_UNLOAD)) %THEN %DO;
		/* Cycle through tables to unload */
		%IF %SYMEXIST(UNLTABLES) %THEN %DO; %SYMDEL UNLTABLES; %END;
		options nonotes;
		proc sql noprint;
		   select fullref
			into :UNLTABLES separated by '|'
			from &UNLLIST. 
			;
		quit;
		options notes;

		%if %SYMEXIST(UNLTABLES) %THEN %DO;
			%put NOTE: SCANNING %nrbquote(&UNLTABLES.);
			%let pos=1;
			%let TBL=%QSCAN(%nrbquote(&UNLTABLES.),&pos.,|);
		   	%DO %WHILE ("%nrbquote(&TBL.)" ne ""); 
				%PUT ---------------------------------------------------;
				%TIMESTAMP( %nrbquote(UNLOADING &TBL. FROM LASR), SHOW=YES, LEVEL=ACTION );
				%PUT ---------------------------------------------------;
				%LET TBLONLY=%SplitLibTable(data=%nrbquote(&TBL.),part=TABLE);

				%msg(msg=%str(REMOVE FROM LASR));
				%DeleteDataSetIfExists( data=%KTRIM(&AL_LIBREF.).%nrbquote(&TBLONLY.));
			
				%if (&SYSERR. gt 4) %then %DumpError;

				%let POS=%eval(&pos.+1);
				%let TBL=%QSCAN(%nrbquote(&UNLTABLES.),&pos.,|);
			%END;
		%END;
	%END; /* Unload */

	/* RELOAD-ON-START  */
	/* If Reload-On-Start is enabled (i.e. we started the server), then reload tables */

	%IF ( %ISYES(AL_OPTION_ROS_ENABLED) ) %THEN %DO;

		%msg(msg=%str(RELOAD-ON-START));

		/* Cycle through reload-on-start libraries */
		%IF %SYMEXIST(ROSLIBRARIES) %THEN %DO; %SYMDEL ROSLIBRARIES; %END;
		options nonotes;
		proc sql noprint;
		   select libname
			into :ROSLIBRARIES separated by '|'
			from &ROSLIBS. 
			;
		quit;
		options notes;
		%if %SYMEXIST(ROSLIBRARIES) %THEN %DO;
			%put NOTE: SCANNING %nrbquote(&ROSLIBRARIES.);
			%let libpos=1;
			%let ROSLIB=%QSCAN(%nrbquote(&ROSLIBRARIES.),&libpos.,|);

			/* FOR EACH LASR RELOAD-ON-START LIBRARY FOUND */
		   	%DO %WHILE ("%nrbquote(&ROSLIB.)" ne "");
				%PUT ---------------------------------------------------;
				%TIMESTAMP( %nrbquote(RELOAD-ON-START FOR LIBRARY &ROSLIB.), SHOW=YES, LEVEL=ACTION );
				%PUT ---------------------------------------------------;
				%msg(msg=%str(RELOAD-ON-START FOR LIBRARY &ROSLIB.));

				%let RSPREFIX=RS&LIBPOS._;

				/* Assign the data provider library */
			  	libname &&&RSPREFIX.DPLIBREF. &&&RSPREFIX.DPLIBENGINE. "&&&RSPREFIX.DPPATH.";

				/* Assign LASR library */
			  	%AssignLASRLibrary	( libref=&&&RSPREFIX.LIBREF.
									, host=&&&RSPREFIX.LASRHOST., port=&&&RSPREFIX.LASRPORT., tag=&&&RSPREFIX.LIBTAG.
									, signer=&&&RSPREFIX.SIGNER. );

				/* Cycle through tables to reload */
				%LET ROSTABLES=;
				%LET ROSSQUEEZE=;
				%LET ROSCOPIES=&&&RSPREFIX.TABLEFULLCOPIES.;
				%LET FULLCOPYTO=;
				%IF (%LENGTH(&ROSCOPIES.) ne 0) %THEN
					%LET FULLCOPYTO=%str(fullcopyto=%KTRIM(&ROSCOPIES.));

				options nonotes;
				proc sql noprint;
				   select fullref,lasrcompress,tblid
					into :ROSTABLES separated by '|',:ROSSQUEEZE separated by '|',:ROSTBLIDS separated by '|'
					from &ROSLIST.&LIBPOS. 
					;
				quit;
				options notes;
				%if %SYMEXIST(ROSTABLES) %THEN %DO;
					%put NOTE: SCANNING %nrbquote(&ROSTABLES.);
					%let pos=1;
					%let TBL=%QSCAN(%nrbquote(&ROSTABLES.),&pos.,|);
					%let TID=%QSCAN(%nrbquote(&ROSTBLIDS.),&pos.,|);
					%let SQZ=%QSCAN(%nrbquote(&ROSSQUEEZE.),&pos.,|);
				   	%DO %WHILE ("%nrbquote(&TBL.)" ne "");
						%if ( %SYSFUNC(exist(%nrbquote(&TBL.))) ) %then %do;
							%PUT ----------------------------------------------------------------;
							%TIMESTAMP( %nrbquote(RELOADING &TBL. (SQUEEZE=&SQZ.) TO LASR), SHOW=YES, LEVEL=ACTION );
							%PUT ----------------------------------------------------------------;

							%LoadTableToLASR	( data=%NRBQUOTE(&TBL.)
												, libref=&&&RSPREFIX.LIBREF.
												, dsopts=%str(squeeze=&SQZ. &FULLCOPYTO.)
												); 
							%if (&SYSERR. le 4) %then %do;
								%msg(msg=%str(SYNCHRONIZE METADATA FOR &TBL. %(&TID.%)));
								%RegisterTable	( REPOSITORY=%nrbquote(&AL_METAREPOSITORY.)
												, LIBRARY=%nrbquote(&&&RSPREFIX.LIBNAME.)
												, TABLEID=%nrbquote(&TID.)
												);
							%end;
							%else %DumpError;

							%if (&SYSERR. gt 4) %then %DumpError;
						%end;
						%else %do;
							%msg(msg=%str(SKIPPING RELOAD FOR &TBL..  TABLE NOT PRESENT IN DATA PROVIDER LIBRARY.));
						%end;

						%let POS=%eval(&pos.+1);
						%let TBL=%QSCAN(%nrbquote(&ROSTABLES.),&pos.,|);
						%let TID=%QSCAN(%nrbquote(&ROSTBLIDS.),&pos.,|);
						%let SQZ=%QSCAN(%nrbquote(&ROSSQUEEZE.),&pos.,|);
					%END;
				%END;

				%let LIBPOS=%eval(&libpos.+1);
				%let ROSLIB=%QSCAN(%nrbquote(&ROSLIBRARIES.),&libpos.,|);
			%END;
		%END;
	%END;

	/* If debug is enabled, then set state back to original  */
	%IF ( %ISYES(AL_OPTION_DEBUG_ENABLED) ) %THEN %DO;
		%setoption(restore,mprint);
		%setoption(restore,mfile);
	%END;

	/* Cleanup PID file */
	%DeleteProcessIDFile;

	/* Get Date Time String */
	%GetDateTimeString;
	%let MSG=%str(&AL_PRODNAME. &AL_PRODVERS. completed at &DATETIME.);	%let MSG=%SUPERQ(MSG);
	%msg( msg=&MSG.);
%mend IMAutoLoadMain;

/*%STOPLASRSERVER(HOST=&AL_LASRHOST., PORT=&AL_LASRPORT., SIGNER=&AL_SIGNER.);*/
