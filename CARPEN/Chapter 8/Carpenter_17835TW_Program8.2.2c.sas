* Program 8.2.2c.sas
* Coding without using %GOTO;

%macro smart(dsn);
  %*AVOID GOTO WHEN POSSIBLE;
  data wt;
  set &dsn;
  %if &dsn=FEMALE %then wt = wt*2.2;;
  run;
%mend smart;
