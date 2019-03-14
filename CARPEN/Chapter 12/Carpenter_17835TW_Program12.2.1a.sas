* Program 12.2.1a.sas
* Determine the next available title;

%macro printit;
%local t u v;

proc sql;
   reset noprint;
   select max(number) into :t 
      from dictionary.titles
         where type='T';
   quit;

%if &t > 8 %then %let u=9; /* title loss */
%else %let u = %eval(&t + 1);
%let v=%eval(&u+1);


title&u 'First custom title';
title&v 'Second custom title';
proc print data=sashelp.class(obs=5);
run;
title&u; 
%mend printit;
title1 'test of custom titles';
%printit

