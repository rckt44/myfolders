* Program 8.3.2c
* Checking Condition codes;

%macro RunCheck(codeval);
run;   /* terminate the step */
%if &syscc > &codeval %then %do;
   %put ERROR: Condition Code &syscc exceeds &codeval;
   %put Aborting Process;
   %abort abend;
%end;
%else %if &syscc>0 %then %do;
   %put WARNING: Condition Code &syscc within limits;
   %let syscc=0;
%end;
%else %do;
   %let syscc=0;
%end;
%mend runcheck;

proc print data=sashelp.class;
   var name ht wt;
   run;
   %put &=syserr &=syscc;
proc print data=sashelp.class;
   var name ht wt;
   %runcheck(500)
proc print data=sashelp.class;
   var name height weight;
   %runcheck(0)
