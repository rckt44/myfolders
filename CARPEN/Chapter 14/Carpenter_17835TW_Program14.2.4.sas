* Program 14.2.4.sas
* Executing lists of unknown names.;

%macro PrtLists;
   %local i;
   %* Create lists;
   proc sql noprint;
      select dsn, keyvar
         into :dsnlst separated by '|',
              :keylst separated by '|'
            from macro3.dbdir;
      %let dsncnt=&sqlobs;
      quit;
   %matrixprint(dlist=dsnlst,vlist=keylst,listcnt=dsncnt)
%mend Prtlists;
%macro matrixprint(DList=,VList=,ListCnt=);
   %local i;
   %do i = 1 %to &&&listcnt;
      proc print data=macro3.%qscan(%unquote(&&&dlist,&i,%str(|))); 
         by %qscan(&&&vlist,&i,%str(|));
         run;
   %end;
%mend matrixprint;

%prtlists
