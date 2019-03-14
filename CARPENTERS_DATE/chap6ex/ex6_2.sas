%LET rawdate=%SYSFUNC(DATE());
%LET date=%SYSFUNC(DATE(),WORDDATE32.);

TITLE "Today's SAS Date Value is &rawdate";
TITLE2 "Formatted date: &date";

PROC PRINT DATA=sashelp.class (OBS=5);
ID name;
VAR age;
RUN;
