LIBNAME ch6 'chap6ex';
PROC EXPAND DATA=ch6.month OUT=annual FROM=MONTH TO=YEAR;
CONVERT riders;
RUN;

PROC PRINT DATA=annual NOOBS;
RUN;