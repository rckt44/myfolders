* Program A1.6.2.sas
* Using the analysis data as its own control file,
* create a separate data set for each region;

%macro RegionRpt;
   * Build a macro variable for each level of REGION;
   proc sql noprint;
      select distinct region
         into :reg1 - 
            from macro3.clinics;
      %let total = &sqlobs;
      quit;

   * Break up the data set into one per region;
   data
     %* Build the names of the new data sets;
     %do i = 1 %to &total;
       reg&i
     %end;
     ;
     set macro3.clinics;
     %do i = 1 %to &total;
       %* Build the output statements;
       %if &i^=1 %then else;
       if region="&i" then output reg&i;
     %end;
     run;

   * Separate analyses for each level of REGION; 
   %do i=1 %to &total; 
      title1 "Region: &&reg&i";
      proc print data=reg&i(obs=10);
         var clinname sex edu ht wt;
         run;
      proc report data=reg&i
                  nowd;
         column clinname ht wt;
         define clinname / group;
         define ht / mean;
         define wt / mean;
         run;
      proc tabulate data=reg&i;
         class sex edu;
         var ht wt;
         table edu, sex*(ht wt)*(n mean stderr);
         run;
   %end;
%mend regionrpt;
%regionrpt
