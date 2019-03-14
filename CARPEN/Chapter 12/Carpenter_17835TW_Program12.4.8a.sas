* Program 12.4.8a.sas
* Control a process using a macr variable list;

%macro fixraw;
%local fixcnt i ;

%* Convert the data fixraw file from csv to a SAS data set;
PROC IMPORT OUT= FixRaw
            DATAFILE= "&path\data\FixRaw.csv" 
            DBMS=csv REPLACE;
     guessingrows=80;
     GETNAMES=YES;
   RUN;

%* Build macro variable lists from the controldata;
proc sql noprint;
select datatable, varname, action, format, chk_type
   into :dsn1     - :dsn999,
        :varname1 - :varname999,
        :action1  - :action999,
        :fmt1     - :fmt999,
        :chktyp1  - :chktyp999
      from fixraw;
   %let fixcnt=&sqlobs;
quit;

%* Call the macro specific to this action;
%do i = 1 %to &fixcnt;
   %&&action&i(dsn=&&dsn&i,var=&&varname&i, fmt=&&fmt&i, chktype=&&chktyp&i)
%end;
%mend fixraw;
options nomprint;
%fixraw
