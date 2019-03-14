* Program 11.9.1c.sas
* Retrieving variables;

proc summary data=macro3.clinics;
   class sex;
   var ht wt;
   output out=summary
          n=  
          mean= /autoname;
   run;

title '11.9.1b Consistent naming using AUTONAME';
proc print data=summary;
   run;

proc contents data=summary
              out=cont
              noprint;
   run;

data _null_;
   set cont end=eof;
   if index(name,'_Mean') then do;
      * Gather the names of variables with the MEAN;
      i+1;
      call symputx(catt('Mean',i),name);
      end;
   if index(name,'ht') then do;
      * Gather the names of variables with a height statistic;
      j+1;
      call symputx(catt('HT',j),name);
      end;
   if eof then do;
      call symputx('meancnt',i);
      call symputx('HTcnt',j);
      end;
   run;
%put &mean1 &mean2;
%put &ht1 &ht2;
%put &=meancnt;
%put &=htcnt;
