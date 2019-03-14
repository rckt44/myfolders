* Program 7.6.3a.sas
* Incremnting by a number of years;

%macro AddYears(base,add);
     intnx('month',&base,&add*12) + (day(&base) - 1)
%mend;

%macro AddYears(base,add);
     intnx('year',&base,&add,'s')
%mend;
options mprint;
data _null_;
today=date();
yearfromnow = %addyears(today,1);
put  yearfromnow= date9.;
run;
data _null_;
date='29feb2000'd;
nextyr = %addyears(date,1);
put nextyr= date9.;
nextyr = intnx('year',date,1,'s');
put nextyr= date9.;
run;

%**************************************************;
%* As a macro function;
%macro AddYears(base,add);
     %sysfunc(intnx(year,&base,&add,s),worddate18.)
%mend addyears;

%put %addyears(%sysfunc(today()),1);

* This will not work;
data _null_;
today=date();
yearfromnow = %addyears(today,1);
put  yearfromnow= date9.;
run;
