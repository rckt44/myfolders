* Program 11.2.1.sas
* Using SASHELP.VTITLE to select the next title;

%macro look(dsn);
%local maxn;
* Determine the next available title;
proc sql noprint; 
   select max(number)  
      into :maxn  
         from sashelp.vtitle   
            where type='T';  
   quit;

title%eval(&maxn+1) "Listing of &dsn";
proc print data=&dsn;
   run; 
title%eval(&maxn+1);  

%mend look;
%look(sashelp.class)
