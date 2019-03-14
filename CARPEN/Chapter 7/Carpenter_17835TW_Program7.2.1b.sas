* Program 7.2.1a.sas
* Using the %INDEX function in an %IF;


%macro check(value=);
     %if %index(&value,emergency) %then 
          %put ERROR: *** Critical Emergency***;
     %else %put NOTE: *** Process in bounds ***;
%mend check;
%check(value=watch engineering emergency)

