* Program 14.5.4.sas
* Table assignment with SYMPUTX;

%symdel cntmales;
 
%macro cntmales;
   %local cntmales;  
   data malesonly;
      set macro3.clinics end=eof;
      if sex='M' then do;
         cnt+1;
         output malesonly;
      end;
      if eof then call symputx('cntmales',cnt);

%mend cntmales;


%cntmales
title "Number of Males is &cntmales";  
proc print data=malesonly(obs=5);
   var lname fname sex;
   run;

%cntmales
proc print data=malesonly(obs=5);
   var lname fname sex;
   title "Number of Males is &cntmales"; 
   run;
