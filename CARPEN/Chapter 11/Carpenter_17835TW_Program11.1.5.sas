* Program 11.1.5
* Branching using %IF-%THEN %DO;

%macro showdat;
...code not shown...
%if &nobs ge 10 %then %do;
   proc means data=statdata mean n stderr;
   var ht wt;
   title "Analysis Data - &nobs Observations";
   run;
%end;
%else %if &nobs gt 0 %then %do;
   proc print data=statdata;
   var subject ht wt;
   title "Data NOT Summarized";
   run;
%end;
%else %put Data Set STATDATA is empty; 
...code not shown...
%mend showdat;
