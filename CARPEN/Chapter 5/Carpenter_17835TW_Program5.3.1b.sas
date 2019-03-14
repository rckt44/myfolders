* Program 5.3.1b
* Using %DO to control semicolons;

%macro dastep(state=AZ);
data subhosp;
  %if &state=CA %then %do; 
      set cahosp;
  %end;
  %else %do; 
      set azhosp;
  %end;
    where date>'19jun2014'd;
    run;
%mend dastep;

* Create test data;
data cahosp;
city='LA';
date= '23jul2014'd;
run;
data azhosp;
city='PHX';
date= '20aug2014'd;
run;
%dastep(state=CA)
