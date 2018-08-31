/*
 * AutoLoad
 *
 * Purpose: Synchronizes SAS data sets placed in a single disk location with
 *			a single LASR Analytic Server library defined in metadata.
 *
 */

/* Set the name of the LASR library to which to Auto Load */
%LET AL_META_LASRLIB=Visual Analytics Public LASR;

/* Include and execute main AutoLoad functionality */
%LET INCLUDELOC=D:\SAS\BIN\SASVisualAnalyticsHighPerformanceConfiguration\7.3\config\Deployment\Code\AutoLoad/include;

filename incuser "D:\SAS\Config\Lev1\SASMeta\MetadataServer";
%include incuser ( metaparms.sas );

/* ------- No edits necessary below this line -------- */

filename inclib "&INCLUDELOC.";
/*
%include inclib ( AutoLoadMain.sas );
%AutoLoadMain;
*/
options validvarname=ANY;
%LET INCLUDELOCIM=D:\SAS\BIN\SASVisualAnalyticsHighPerformanceConfiguration\7.3\config\Deployment\Code\AutoLoad/include_imstat;
filename inclibim "&INCLUDELOCIM.";
%include inclibim ( IMAutoLoadMain.sas );
%IMAutoLoadMain;
