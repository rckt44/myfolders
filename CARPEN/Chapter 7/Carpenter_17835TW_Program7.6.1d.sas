* Program 7.6.1d.sas
* Formatting todays date;

%macro currdate;
   %qtrim(%qleft(%qsysfunc(date(),worddate18.)))
%mend currdate;

%put Today is |%currdate|;
