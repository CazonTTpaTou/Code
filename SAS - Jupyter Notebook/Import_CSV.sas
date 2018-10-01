
/** Import an XLSX file.  **/

PROC IMPORT DATAFILE="WEOApr201Galla.xlsx"
    OUT=WORK.MYEXCEL
    DBMS=XLSX
  REPLACE;
  getnames=no;
RUN;

PROC CONTENTS data=WORK.MYEXCEL;
RUN;


DATA work.year_1980 (keep= numeric_1980 numeric_1998 I AA AB AC AH);
SET work.myexcel;
IF I = 'n/a' THEN I=0;
IF AA = 'n/a' THEN AA=0;
numeric_1980 = input(I, COMMA10.);
numeric_1998 = input(AA,COMMA10.);
RUN;


PROC PRINT data=work.year_1980 (obs=15);
RUN;


PROC SGPLOT data=work.year_1980;
scatter X=numeric_1980 
        Y=numeric_1998;
reg X=numeric_1980
    Y=numeric_1998;
RUN;

