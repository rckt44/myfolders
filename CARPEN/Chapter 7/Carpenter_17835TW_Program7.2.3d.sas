* Program 7.2.3d.sas
* Using the %QSCAN function to mask ampersands;

%let dsn = clinics;
%let string = %nrstr(*&stuff*&dsn*&morestuf);

%let wscan = %scan(&string,2,*);
%let wqscan = %qscan(&string,2,*);

%put &wscan &wqscan;
