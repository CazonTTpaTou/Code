filename incuser "D:\SAS\Config\Lev1\SASMeta\MetadataServer";
%include incuser ( metaparms.sas );
options validvarname=ANY;
libname LASRLIB SASIOLA HOST="srv-sasva.photowatt.local" PORT=10031 TAG="VAPUBLIC" 
SIGNER="https://sas.photowatt.com:443/SASLASRAuthorization" ;

proc metalib;
 omr ( library="Visual Analytics Public LASR                                                                
                                    " REPNAME="'Foundation'" );
  folder="/Shared Data/SAS Visual Analytics/Public/LASR";
  select ("TDB_V_LOTS_SYNTHESE_2");
  run;
