* Program 7.6.1k.sas
* Retrieving the last word in a list of words;

%macro listlast(list);
   %sysfunc(reverse(%scan(%sysfunc(reverse(&list)),1,%str( ))))
%mend listlast;
