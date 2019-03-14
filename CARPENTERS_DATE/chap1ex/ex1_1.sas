DATA date_constants; 
date = '04aug2013'd;  /* This is a date constant */
time = '07:15:00't;   /* This is a time constant */
datetime = '07aug1904:21:31:00'dt;  /* This is a datetime constant */
RUN;

TITLE "Unformatted Constants";
PROC PRINT DATA=date_constants;
VAR date time datetime;
RUN;

TITLE "Formatted Constants";
PROC PRINT DATA=date_constants;
VAR date time datetime;
FORMAT date worddate32. time timeampm9. datetime datetime19.;  /* Format the constants */
RUN;
