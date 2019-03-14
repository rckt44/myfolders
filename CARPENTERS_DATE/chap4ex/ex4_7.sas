LIBNAME ch4 'chap4ex';
DATA interval_end;
SET ch4.interval;
CALL IS8601_CONVERT('intvl','end',interval,end);
FORMAT interval $N8601E. end DATETIME20.; 
RUN;
