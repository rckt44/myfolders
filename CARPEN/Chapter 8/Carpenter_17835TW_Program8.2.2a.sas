* Program 8.2.2a.sas
* Using %GOTO with explicit labels;

%macro mkwt(dsn);
%* Point directly to the label;
%if &dsn = MALE %then %goto male;
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
%mend mkwt;
