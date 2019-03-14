* Program 7.2.3b.sas
* Using the %SCAN function to select words;

%let x=XYZ.A'BC'/XYY;
%let slash=%scan(&x,1,/);
%put The one word before slash is &slash;


