* Program 7.1.1b.sas
* Show the use of the %BQUOTE quoting function;
%macro drop(droplist=);
     %if &droplist ne %then
          %bquote(drop &droplist;);
%mend drop;

%drop(droplist=x1-x12)

%drop(droplist=x1)
