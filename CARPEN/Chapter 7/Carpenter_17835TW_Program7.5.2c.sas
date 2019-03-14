* Program 7.5.2c.sas
* Testing to see if a data set exists
* using the EXIST function;

%macro exist(dsn);
    %* The following sysfunc call results
    %* in a non-zero value when the data
    %* set exists;
    %sysfunc(exist(&dsn))
%mend exist;

%put |%exist(macro3.clinics)|;
