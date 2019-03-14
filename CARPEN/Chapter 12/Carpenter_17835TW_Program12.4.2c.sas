* Program 12.4.2c.sas
* Create a list of unknown variable names
* using SQL;

%macro VList(dsn=, bylist=, id=, var=);
%global varlist;
*** create the transposed data set; 
proc sort data=&dsn(keep=&bylist &id &var)
          out=srtdata
          nodupkey;
   by &bylist &id;
   run;
proc transpose data=srtdata
               out=trnsdata;
   by &bylist;
   id &id;
   var &var;
   run;
 
* create a space-delimited variable list using a SQL step ;
proc sql noprint;
select distinct name 
   into :varlist separated by ' '
      from dictionary.columns 
         where (libname='WORK' & memname='TRNSDATA' &
                name not in('_NAME_' '_LABEL_'));
quit;

%put &=varlist;
%mend VList;
%let varlist=;
%VList(dsn=sashelp.shoes, bylist=region subsidiary, id=product, var=sales)
