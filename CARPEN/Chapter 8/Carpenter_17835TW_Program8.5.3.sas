* Program8.5.3.sas
* Detecting macro variables and their symbol tables;

%global City state;
%let city = Los Angeles;
%let state= CA;
%macro test;
%local city;
%let city=Anchorage;
data _null_;
   var='state';
   if symexist("city") then do;
      if symlocal('city') then put 'macro variable city exists locally';
      if symglobl('city') then put 'macro variable city exists globally';
      if symglobl(var) then put 'macro variable ' var ' exists globally';
   end;
   run;
%mend test;
%test



