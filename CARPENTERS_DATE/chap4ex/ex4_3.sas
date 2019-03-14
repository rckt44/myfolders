DATA howlong;
LENGTH period $ 16;
period = "P4W";
CALL IS8601_CONVERT('du','du',period,howlong);
howlong_disp = STRIP(PUT(howlong,time10.1));
OUTPUT;
period = "P3DT4H27M16.8S";
CALL IS8601_CONVERT('du','du',period,howlong);
howlong_disp = STRIP(PUT(howlong,time10.1));
OUTPUT;
RUN;

PROC PRINT DATA=howlong NOOBS;
RUN;
