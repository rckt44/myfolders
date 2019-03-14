* Program 5.2.2a
* Building a SET statement dynamically;

%macro dastep(state=AZ);
data subhosp;
    set
  %if &state=CA %then cahosp;
  %else azhosp;
    ;  
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
