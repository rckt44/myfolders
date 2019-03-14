* Program 6.4.1b
* Using the analysis data as its own control file;

%macro RegionRpt;
   * Build a macro variable for each level of REGION;
   proc sql noprint;
      select distinct region
         into :reg1 - 
            from macro3.clinics;
      %let total = &sqlobs;
      quit;

   * Separate analyses for each level of REGION; 
   %do i=1 %to &total; 
      title1 "Region: &&reg&i";
      proc print data=macro3.clinics(where=(region="&&reg&i")
                                       obs=10);
         var clinname sex edu ht wt;
         run;
      proc report data=macro3.clinics(where=(region="&&reg&i"))
                  nowd;
         column clinname ht wt;
         define clinname / group;
         define ht / mean;
         define wt / mean;
         run;
      proc tabulate data=macro3.clinics(where=(region="&&reg&i"));
         class sex edu;
         var ht wt;
         table edu, sex*(ht wt)*(n mean stderr);
         run;
   %end;
%mend regionrpt;
%regionrpt
