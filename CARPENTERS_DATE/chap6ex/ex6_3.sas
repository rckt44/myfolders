%LET filedate=%SYSFUNC(DATE(),yymmddd10.);

PROC PRINT DATA=sashelp.cars NOOBS LABEL;
RUN;
