* Program6.5.2b.sas
* Timing of the execution of a macro
* which includes a DATA step;

* The following demonstrates the timing of events;
%macro timing2(dset=);
   %put In timing2 &=dset;
   data silly;
      x="&dset";
      put x=;
      run;
%mend timing2;
data _null_;
   set macro3.dbdir;
   call execute('%timing2(dset='||dsn||')');
   put dsn=;
   run;

