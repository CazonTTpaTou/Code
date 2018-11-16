
%let FileName='W_AviationData.txt';

proc import datafile=&FileName
    out=work.planes
    dbms=csv replace;
    getname=yes;
    delimiter='|';
    options validvarname = V7;
RUN;    

PROC contents data=work.planes;
run;

PROC SGPLOT data=work.planes;
scatter x=_Event_Date
        y=_Total_Fatal_Injuries;
RUN;


data work.planes_recent;
set work.planes;
if _event_date >1980 and _total_fatal_injuries>10 then output;
run;

proc sgplot data=work.planes_recent;
scatter x=_event_date
        y=_total_fatal_injuries;
reg x=_event_date
    y=_total_fatal_injuries;
run;


Data work.planes_recent2 (keep= nb_jours _event_date _total_fatal_injuries _airport_name number_event _country);
set work.planes_recent;
attrib nb_jours
label ="Nombre de jours"
length = 3;
nb_jours = MAX(of _event_date:) - year(_Event_Date);
number_event = N(of _event_date:);
run;


proc print data=work.planes_recent2 (obs=5);
run;

PROC SORT data=work.planes_recent2 out=work.planes_recent_sort;
by _Airport_Name;
run;

data work.planes_recent_sort_2;
set work.planes_recent_sort;
by _airport_name;
if first._airport_name then output;
run;


proc print data=work.planes_recent_sort_2 (obs=5);
run;

data work.planes_recents_sort_3;
set work.planes_recent_sort_2;
by _airport_name;
attrib delta_airport
       label = "delta Airport"
       length=3;
airport_delta = _total_fatal_injuries - lag(_total_fatal_injuries);
run;


proc print data=work.planes_recents_sort_3 (obs=10);
run;

proc sort data=work.planes_recents_sort_3 out=work.planes4;
by _country;
run;

proc print data=work.planes4 (obs=2);
run;

data work.planes5;
set work.planes4;
by _country;
if first._country then total=0;
if not missing(_airport_name) then total + _Total_Fatal_Injuries;
run;


proc print data=work.planes5 (obs=5);
run;

data work.planes6;
set work.planes5;
array injuries inj1-inj4;
DO i=1 to 4;
    injuries(i) = _total_fatal_injuries * i;
END;
RUN;


proc print data=work.planes6 (obs=5);
run;


proc format;
    value injuries
        low-10000 = 'Low'
        10000-20000 = 'Medium'
        20000-HIGH = 'High';
RUN;        

data work.planes7 (keep=_country inj2 _total_fatal_injuries injury multiple);
attrib injury
label='Type Injury' 
format=injuries.;
set work.planes6;
injury = _total_fatal_injuries;
if mod(inj2,3)=0 then multiple='Yes';else multiple='No';
run;


proc print data=work.planes7 (obs=5);
run;

%macro number_obs(table);
    %global nb;
    proc sql noprint;
        select count(*) into :nb from &table;
    quit;
%mend number_obs;


%number_obs(work.planes7);
%put Number of rows --> &nb;

proc anova data=work.planes7;
    class _country;
    model inj2=_country;
    means _country / tuckey;
run;    
        

%macro counter(number);
%do i=1 %to &number;
    %put --> &i;
%end;
%mend counter;

%counter(10);

PROC FREQ data=work.planes7;
run;

