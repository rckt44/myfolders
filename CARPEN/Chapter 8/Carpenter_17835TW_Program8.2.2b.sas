* Program 8.2.2b.sas
* Using %GOTO with implicit labels;

%macro make(dsn);
%* Point indirectly to the label;
%goto &dsn;
%female:
  data wt;
  set female;
  wt = wt*2.2;
  run;
%goto next;
%male:
  data wt;
  set male;
  run;
%next:
%mend make;
