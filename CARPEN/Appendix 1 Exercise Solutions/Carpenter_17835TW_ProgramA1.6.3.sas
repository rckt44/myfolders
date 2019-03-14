* Program A1.6.3.sas
* Using the analysis data as its own control file,
* create a separate data set for each region.
* Make sure that the value of REGION is a part of the data set name.;

%macro RegionRpt(dsn=macro3.clinics);
   %local i;
   * Build a macro variable for each level of REGION;
   proc sql noprint;
      select distinct region
         into :reg1 - 
            from &dsn;
      %let total = &sqlobs;
      quit;

   * Break up the data set into one per region;
   data
     %* Build the names of the new data sets;
     %do i = 1 %to &total;
       reg_&&reg&i
     %end;
     ;
     set &dsn;
     %do i = 1 %to &total;
       %* Build the output statements;
       %if &i^=1 %then else;
       if region="&&reg&i" then output reg_&&reg&i;
     %end;
     run;

   * Separate analyses for each level of REGION; 
   %do i=1 %to &total; 
      title1 "Region: &&reg&i";
      proc print data=reg_&&reg&i(obs=10);
         var clinname sex edu ht wt;
         run;
      proc report data=reg_&&reg&i
                  nowd;
         column clinname ht wt;
         define clinname / group;
         define ht / mean;
         define wt / mean;
         run;
      proc tabulate data=reg_&&reg&i;
         class sex edu;
         var ht wt;
         table edu, sex*(ht wt)*(n mean stderr);
         run;
   %end;
%mend regionrpt;

* Reset the value of region 5 just for fun;
data clinics;
   set macro3.clinics;
   if region='5' then region='Q5';
   run;
%regionrpt(dsn=clinics)
