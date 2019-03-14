data ex4_2;
INPUT @1 duration_string $16. @18 inf $8.;
stored = INPUTC(duration_string,inf);
fmt_stored = PUT(stored,$n8601b.);
DATALINES;
P00020806T0100   $N8601B.
P00020806T0100   $N8601E.
RUN;

PROC PRINT DATA=ex4_2 NOOBS;
var inf duration_string stored fmt_stored;
RUN;
