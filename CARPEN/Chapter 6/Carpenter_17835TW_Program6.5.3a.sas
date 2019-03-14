* Program6.5.3a.sas
* Compile time execution of macro language elements;

%macro doit;
 proc print data=a; run;
%mend doit;

data a;
   set macro3.dbdir;
   call execute(%doit);
   run;

