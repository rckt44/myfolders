* Program 7.2.3c.sas
* Using the %SCAN function to select words;

%let x=XYZ.A'BC'/XYY;
%let two=%scan(&x,2,'/');
%let three=%scan(&x,3,'/');
%put The second word is &two;
%put The third word is &three;


data _null_;
x="XYZ.A'BC'/XYY";
two=scan(x,2,"'/'");
three=scan(x,3,"'/'");
four=scan(x,4,"'/'");
put (_all_) (=);
run;
