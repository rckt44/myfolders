libname ch4 'chap4ex';
DATA interval;
SET ch4.sample;
LENGTH interval formatted_interval $ 32;
CALL IS8601_CONVERT('dt/du','intvl',aestdtm,duration,interval);
formatted_interval = interval;
FORMAT formatted_interval $N8601E.;
RUN;
