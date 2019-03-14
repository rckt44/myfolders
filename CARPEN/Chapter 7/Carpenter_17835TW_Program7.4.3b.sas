* Program 7.4.3a.sas
* Using %SYSFUNC with PUTN and the HEX. format;

%macro pattern(dsn=,pievar=);
%local g i j nslice;

* Determine the number of unique values of the
* variable that will be used to determine the slices;
proc sql noprint;
select count(distinct &pievar) into :nslice 
   from &dsn;
   run;

%do j = 1 %to &nslice;
   %* Create &nslice pattern statements;
   %let i=%sysevalf(255/(&nslice+1)*&j,floor); 
   %let g=%sysfunc(putn(&i,hex2.)); 
   pattern&j v=psolid c=gray&g r=1;  
%end;
%mend pattern;
options mprint; 
%pattern(dsn=macro3.biomass, pievar=station)

title1 'Shades of Gray';
proc gchart data=macro3.biomass;
pie station;
run;
quit;
