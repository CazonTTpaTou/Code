/*
 * IMLoadTableToLASR
 *
 * Purpose: Loads a table to a LASR library
 *
 * Parameters:
 *
 *		refresh=	memory data has to be refreshed
 *		data=		The source data to load to the target library
 * 		libref=		The already-assigned libref into which to load the table
 *      dsopts=		Additional data set options for performing the load
 *
 */ 
%macro IMLoadTableToLASR(  refresh=
                         , data=
						 , libref=
						 , dsopts=
						 );
	/* Compute date string label for load */
	%GetDateTimeString(var=DTSTRING);

	%let tablepart 	= %SplitLibTable(data=%nrbquote(&data.), part=TABLE);
	%let libpart	= %SplitLibTable(data=%nrbquote(&data.), part=LIBRARY);
	%let tablepart 	= %NLITERAL(&tablepart.);
	%setoption(on,fullstimer);
	%setoption(on,source);
	
	/* on refresh action */
	
	%if "&refresh" eq "Yes" %then %do;
	
	LIBNAME LASRLIB SASIOLA  TAG=VAPUBLIC  PORT=10031 HOST="srv-sasva.photowatt.local"  SIGNER="http://srv-sasva.photowatt.local:80/SASLASRAuthorization" ;

	
	/* set the flag to 1 on source data */
	data &tablepart._A;
	   length UPDATE_FLAG $1;
	   set &libpart..&tablepart.;
	   UPDATE_FLAG="1";
	run;
	
	/* set the flag to 0 on memory */
	proc imstat data=&libref..&tablepart.; 
	   where 1=1;
       UPDATE UPDATE_FLAG="0"; 
    run;
	
    /* load source data on memory */
	%DeleteDataSetIfExists( data=&libref..&tablepart._A);
	
	data &libref..&tablepart._A (&dsopts. label="Auto loaded &DTSTRING.");;
		set &tablepart._A;
	run;
	
	/* append source data on target table memory */
    proc imstat data=&libref..&tablepart.; 
        where 1=1;
        table &libref..&tablepart.; 
        set &tablepart._A / drop; 
    run; 
    quit;
	
	/* delete data on memory with flag 0 */
	
	proc imstat data=&libref..&tablepart.; 
	   where UPDATE_FLAG="0";
       deleterows / purge; 
    run;
	
	%end;
	
	/* on first load action */
	%if "&refresh" eq "No" %then %do;
	
	/* set the flag to 1 on source data */
	data &tablepart._A;
	   length UPDATE_FLAG $1;
	   set &libpart..&tablepart.;
	   UPDATE_FLAG="1";
	run;
	
	%DeleteDataSetIfExists( data=&libref..&tablepart.);
    data &libref..&tablepart. (&dsopts. label="Auto loaded &DTSTRING.");;
		set &tablepart._A;
	run;
	
	%end;
	
	/* update table label */
	/*
	proc datasets library=&libref.;
		modify &tablepart.(label="Auto loaded &DTSTRING.");
	run; 
	*/
    /*	
    data &libref..&tablepart. (&dsopts. label="Auto loaded &DTSTRING.");;
		set &libpart..&tablepart.;
	run;
	*/
	%setoption(restore,source);
	%setoption(restore,fullstimer);
%mend;
