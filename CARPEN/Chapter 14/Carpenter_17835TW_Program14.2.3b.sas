* Program 14.2.3b.sas
* Executing lists of unknown names.;

%macro PrtLists;
   %local i;
   %* Create lists;
   proc sql noprint;
      select dsn, keyvar
         into :dsn1-,
              :keyvar1-
            from macro3.dbdir;
      %let dsncnt=&sqlobs;
      quit;
   %matrixprint(dlist=dsn,vlist=keyvar,listcnt=dsncnt)
%mend Prtlists;
%macro matrixprint(DList=,VList=,ListCnt=);
   %local i;

   %do i = 1 %to &&&listcnt;
      proc print data=macro3.&&&dlist&i; 
         by &&&vlist&i;
         run;
   %end;

%mend matrixprint;

%prtlists
