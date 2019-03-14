* Program 7.2.4a.sas
* Using the %SUBSTR functin;

%macro try;
%LET CLINIC=BETHESDA;
%IF %SUBSTR(&CLINIC,5,4) = ESDA %THEN %PUT *** MATCH ***;
%ELSE %PUT *** NOMATCH ***;
%mend try;
%try
