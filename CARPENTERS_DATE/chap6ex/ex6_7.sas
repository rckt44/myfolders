LIBNAME ch6 'chap6ex';
PROC EXPAND DATA=ch6.month OUT=seven_days FROM=MONTH TO=WEEK;
ID date;
CONVERT riders;
RUN;

PROC PRINT DATA=seven_days NOOBS;
ID date;
RUN;
