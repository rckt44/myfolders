* Program 7.6.1a.sas
* Testing to see if a data set exists
* using the EXIST function;

%macro exist(dsn);
    %sysfunc(exist(&dsn))
%mend exist;

%put |%exist(macro3.clinics)|;
