* Program 7.2.3a.sas
* Using the %SCAN function to select words;

%let x=XYZ.A'BC'/XYY;
%let word=%scan(&x,3);
%let part=%scan(&x,1,Z);
%put word is &word and part is &part;


