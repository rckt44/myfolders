* Program 12.1.1.sas
* Copy selected SAS catalogs;

* Copy catalogs from the TEST to the PRODUCTION
* areas.;

options nomprint nomlogic nosymbolgen;

%macro catcopy(test=,prod=);
%* test  - libref for the test area
%* prod  - libref for the production area
%*;

* Determine catalogs in TEST area;
proc sql noprint;
   select memname
      into :cname1-
         from sashelp.vscatlg
            where libname="%upcase(&test)"
                   and substr(memname,1,2) in ('WE', 'DE', 'ED', 'PH');
   %let catcnt = &sqlobs;
   quit;

proc datasets nolist;
   copy in=&test out=&prod memtype=catalog;
      select
        %do i = 1 %to &catcnt;       
            &&cname&i
        %end;
      ;
   quit;
%mend catcopy;

/*%catcopy(test=tstappls,prod=appls)*/
%catcopy(test=sashelp,prod=work)
