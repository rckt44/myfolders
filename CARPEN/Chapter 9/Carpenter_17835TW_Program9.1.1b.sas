* Program 9.1.1b.sas
* Building a macro call;

%* Call a macro based on a variable value;
%macro asia;
   %put in asia;
%mend asia;
%macro europe;
   %put in europe;
%mend europe;
%macro usa;
   %put in usa;
%mend usa;

%macro regions;
%local i;
proc sql noprint;
   select distinct origin
      into :orig1-
         from sashelp.cars;
   quit;

%do i = 1 %to &sqlobs;
  %&&orig&i
%end;
%mend regions;
%regions
