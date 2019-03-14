LIBNAME ch6 'chap6ex';
PROC EXPAND DATA=ch6.month OUT=quarterly FROM=MONTH TO=QTR;
ID date;
CONVERT riders;
RUN;

PROC PRINT DATA=quarterly NOOBS;
ID date;
RUN;
