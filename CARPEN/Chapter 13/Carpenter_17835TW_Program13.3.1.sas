* Program 13.3.1.sas
* Selecting the top N percent;

%macro toppcnt(dsn,idvar,pcnt);
***********************************************************;
* create table pcnt for indicating &pcnt of ids           *;
***********************************************************;

proc sql noprint;
   select count(distinct &idvar) *&pcnt 
      into :idpcnt 
         from &dsn; 

***********************************************************;
*   sort on descending &idvar                             *;
***********************************************************;

proc sort data= &dsn out=items;
by descending &idvar;
run;

***********************************************************;
*   keep top &IDPCNT %                                    *;
***********************************************************;

data topitems;
set items(obs=%sysevalf(&idpcnt,ceil)); **<—— reflects the % ;
run;
%mend toppcnt;

%toppcnt(sasclass.biomass,bmtotl,.25);
