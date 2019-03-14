LIBNAME ch2 'chap2ex';
PROC FORMAT;
VALUE qualify
LOW-'00:10:00't=[MMSS5.]; 
'00:10:00't <- HIGH = 'Did Not Qualify';
RUN;

/* use these dataset options to get the output in the book (firstobs=23 obs=29) */

PROC PRINT DATA=ch2.racers; 
ID name;
VAR time;
FORMAT time qualify.;
RUN;
