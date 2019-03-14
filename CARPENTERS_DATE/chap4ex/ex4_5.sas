libname ch4 'chap4ex';
DATA ch4.iso_intervals;
SET ch4.aedtm2;
LENGTH interval formatted_interval $ 32;
CALL IS8601_CONVERT('dt/dt','intvl',aestdtm,aeendtm,interval);
formatted_interval = interval;
FORMAT formatted_interval $N8601E.;
RUN;
