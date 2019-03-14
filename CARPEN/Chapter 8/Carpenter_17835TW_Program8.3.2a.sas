* Program 8.3.2a
* Show error and warning text;

%macro copyall(inlib=, outlib=);
proc datasets memtype=data;
   copy in=&inlib out=&outlib;
   quit;
%if &syserr>5 %then %do;
   %put ERROR: &=syserrortext;
   %put ERROR: &=syserr;
   %abort;
%end;
%put Copy was successful;
%mend copyall;
%copyall(inlib=combine, outlib=combtemp)
