* Program6.5.2b.sas
* Timing of the execution of a macro;

* The following demonstrates the timing of events;
%macro timing(dset=);
   %put in timing &=dset;
%mend timing;
data _null_;
   set macro3.dbdir;
   call execute('%timing(dset='||dsn||')');
   put dsn=;
   run;

