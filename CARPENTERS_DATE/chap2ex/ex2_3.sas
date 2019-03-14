DATA test3;
date3 = 19067;
time3 = 18479;
date4 = 18833;
time4 = 45187;
FORMAT date3 date4 DATE9. time3 time4 TIME5.;
RUN;

PROC PRINT DATA =test3 NOOBS;
FORMAT date3 date4 time3 time4;
RUN;

/* Remove format from date4 (incorrect) */
PROC PRINT DATA = test3 NOOBS;
FORMAT date3 MMDDYY10. date4 time3 time4 TIMEAMPM11.;
RUN;

/* Remove format from date4 (correct) */
PROC PRINT DATA =test3 NOOBS;
FORMAT date3 MMDDYY10. time3 time4 TIMEAMPM11. date4;
RUN;

