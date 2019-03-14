LIBNAME ch6 'chapex6';
PROC EXPAND DATA=ch6.month OUT=nomiss;
ID date;
CONVERT riders;
RUN;

PROC PRINT DATA=nomiss NOOBS;
ID date;
RUN;

PROC EXPAND DATA=ch6.month OUT=nomiss2 FROM=MONTH;
ID date;
CONVERT riders;
RUN;

PROC PRINT DATA=nomiss2 NOOBS;
ID date;
RUN;


