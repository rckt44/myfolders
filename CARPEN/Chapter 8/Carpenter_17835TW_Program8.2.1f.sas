* Program8.2.1f.sas
* Deleting global macro variables with %SYMDEL after
* building the macro variable list with SQL;

%macro delvars;
proc sql noprint;
   select  distinct name
      into :GList separated by ' '
         from dictionary.macros
            where scope='GLOBAL' & substr(name,1,3) ne 'SYS';
   quit;
%symdel &glist;
%mend delvars;

%let nada=;
%let dsn=clinics;
%delvars
%put _global_;
