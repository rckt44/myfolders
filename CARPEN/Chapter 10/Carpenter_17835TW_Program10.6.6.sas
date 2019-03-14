* Program 10.6.6
* Using the %DATATYP macro function to detect numeric values;

%let d1 = 2.54;
%let typd1=%datatyp(&d1);
%put &=d1 &=typd1;

%let d2 = 4.3e3;
%let typd2=%datatyp(&d2);
%put &=d2 &=typd2;

%let d3 = abcd3;
%let typd3=%datatyp(&d3);
%put &=d3 &=typd3;
