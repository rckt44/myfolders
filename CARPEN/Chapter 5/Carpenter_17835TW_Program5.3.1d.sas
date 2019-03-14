* Program 5.3.1d
* Using %DO to enclose semicolons;

%macro doboth(indata=,vlist=,cnt=10);
   %if &vlist ne %then %do;
      proc sort data=&indata;
         by &vlist;
         run;
   %end;
   %else %put PROC SORT was not called;

   title1 "data set &indata";
   proc contents data=&indata;
      run;
   proc print data=&indata 
   %if &cnt>1 %then %do; 
      (obs=&cnt); 
      title2 "First &cnt Observations";
   %end;
   %else %do; 
      (obs=max); 
      title2;
   %end;
      run;
%mend doboth;

proc datasets nolist;
   copy in=macro3 out=work;
      select clinics;
   quit;
options nomprint nosymbolgen nomlogic;
%doboth(indata=clinics,vlist=)
%doboth(indata=clinics,vlist=region,cnt=)


