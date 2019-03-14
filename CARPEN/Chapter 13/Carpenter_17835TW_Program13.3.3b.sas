* Program 13.3.3b.sas
* Randomly selecting the data subset;

%macro rand_wo(dsn=,pcnt=100);
   %local obscnt;
   %let obscnt = %obscnt(&dsn);  
   %put obs count is &obscnt;

   * Randomly select observations from &DSN;
   data rand_wo(drop=cnt totl);
      * Calculate the number of obs to read;
      totl = ceil(&pcnt*&obscnt); 
      array obsno {&obscnt} _temporary_;  

 
      do until(cnt=totl);
         point = ceil(ranuni(0)*&obscnt);  
         if obsno{point} ne 1 then do;  
            * This obs has not been selected before;
            set &dsn point=point; 
            output rand_wo;
            obsno{point}=1;  
            cnt+1;
         end;
      end;
      stop;
      run;
%mend rand_wo;
%rand_wo(dsn=macro3.clinics, pcnt=.25)
