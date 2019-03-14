* Program 7.6.1f.sas
* Formatting today as a DB2 datetime value;

%macro fuzzrnge(var,base,disp);
   (%eval(&base-&disp) le &var & &var le %eval(&base+&disp))
%mend fuzzrnge;     

%put %bquote(if %fuzzrnge(age,7,2) then do;);
