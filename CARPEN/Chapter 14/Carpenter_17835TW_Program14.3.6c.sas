* Program 14.3.6c.sas
* Macro variable collisions.;

%macro datsernum(adjust=0);
   %if &adjust= %then %let adjust=0;
   %* Generate the DSN (Dataset Serial Number);
   %let dsn = %eval(5 + &adjust); 
   &dsn
%mend datsernum;

%* Define the data set of interest;
%let dsn = macro3.clinics;

%* Determine the Data Serial Number;
%let sernum = %DatSerNum(adjust=5);

* Create the new data;
data new; 
set &dsn; 
/*...code not shown...*/
run; 
