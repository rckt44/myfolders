* Program 7.2.7.sas
* Demonstrating the %LOWCASE and %QLOWCASE functions;

%let mixed = SAS Macro Language;
%let lower = %lowcase(&mixed);
%put &lower;
