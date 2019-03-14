DATA bad_date_constants; 
date = '04aug2013';  /* This is NOT a date constant */
time = '07:15:00';   /* This is NOT a time constant */
datetime = '07aug1904:21:31:00';  /* This is NOT a datetime constant */
RUN;

TITLE "Unformatted Constants";
PROC PRINT DATA=bad_date_constants;
VAR date time datetime;
RUN
