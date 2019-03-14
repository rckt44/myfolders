* Program 8.3.2b
* Query the error text;

%macro copyall(inlib=, outlib=);
proc datasets memtype=data;
   copy in=&inlib out=&outlib;
   quit;
%if %bquote(&syserrortext) =%bquote(Libref %upcase(&inlib) is not assigned.) %then %makelib(&inlib);
%mend copyall;
%copyall(inlib=combine, outlib=combtemp)
