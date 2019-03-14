* Program 13.3.2.sas
* Selecting the top N percent using POINT and NOBS;

%macro selpcnt(dsn=,idvar=,pcnt=);

* Sort the incoming data set in descending order;
proc sort data=&dsn  
          out=items;
   by descending &idvar;
   run;

* Read the first IDPCNT observations from ITEMS;
data topNitems;
   idpcnt = ceil(nobs*&pcnt);  
   do point = 1 to idpcnt;
      set items point=point nobs=nobs;
      output topnitems;
   end;
   stop;
   run;
%mend selpcnt;

%selpcnt(dsn=macro3.biomass,idvar=bmtotl,pcnt=.25)

