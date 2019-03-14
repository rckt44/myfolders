* Program 7.2.3f.sas
* Using the %SCAN function with modifiers;

%let x = XYZ.aB/ABC//def\'a.b';
%let y1 = %scan(&x,1,/,m b);
%let y2 = %scan(&x,2,/,m b);
%let y3 = %scan(&x,3,/,m b);
%put &=y1 &=y2 &=y3; 

%let y4 = %qscan(&x,2,.,b);
%let y5 = %qscan(&x,2,.,b q);
%put &=y4 &=y5; 
