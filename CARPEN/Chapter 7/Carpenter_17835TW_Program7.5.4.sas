* Program 7.5.4.sas
* Assigning to one higher table;

%macro higher;
   %let name=fred;
%mend higher;

%let name=Susie;
%higher
%put &=name;
