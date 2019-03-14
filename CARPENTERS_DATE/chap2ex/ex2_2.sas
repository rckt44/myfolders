DATA test2;
LENGTH date2 time2 4;
date2 = 19781;
time2 = 73000;
RUN;

PROC PRINT DATA=test2;
FORMAT date2 DATE9. time2 TIMEAMPM11.;
RUN;

PROC PRINT DATA=test; /* from Example 2.1 */
FORMAT date1 WEEKDATE37. time1;
RUN;
