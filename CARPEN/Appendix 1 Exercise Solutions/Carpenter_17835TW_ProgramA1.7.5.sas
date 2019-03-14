* Program A1.7.5.sas
* Return the data set name;

%macro nameonly(dsn);
%local len col name;

%let len = %length(&dsn);
%let col = %index(&dsn,.);
%let name = %substr(&dsn,%eval(&col+1),%eval(&len-&col));
%*let name = %substr(&dsn,%eval(&col+1));
&name
%mend nameonly;

%put name is %nameonly(macro3.biomass);

%* Extra Credit;
%macro nameonly(dsn);
   %scan(&dsn,2,.)
%mend nameonly;
%put name is %nameonly(macro3.biomass);

%* Extra extra credit;
%* This version works even if there is no libref;
%macro nameonly(dsn);
   %scan(&dsn,-1,.)
%mend nameonly;
%put name is %nameonly(biomass);
