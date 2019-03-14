LIBNAME ch4 'chap4ex';
DATA isostore;
SET ch4.isotest1; /* Data set options for output in book (firstobs=14 obs=14) */
LENGTH result1-result2 $ 32;
CALL IS8601_CONVERT('dt/dt','du',dt1,dt2,result1);
CALL IS8601_CONVERT("dt/dt",'intvl',dt1,dt2,result2);
fmt_result1 = PUT(result1,$N8601E.);
fmt_result2 = PUT(result2,$N8601E.);
RUN;

PROC PRINT DATA=isostore NOOBS;
RUN;
