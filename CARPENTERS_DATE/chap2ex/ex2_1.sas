DATA test;
LENGTH date1 time1 4;
date1 = 19781;
time1 = 73000;
FORMAT date1 MMDDYY10. time1 TIMEAMPM11.;
RUN;
