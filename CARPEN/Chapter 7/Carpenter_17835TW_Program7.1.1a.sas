* Program 7.1.1a.sas
* Show the use of the %BQUOTE quoting function;
%macro drop(droplist=);
     %if %bquote(&droplist) ne %then
          %bquote(drop &droplist;);
%mend drop;
%drop(droplist=x1-x3 lastname frstname ssn) 
