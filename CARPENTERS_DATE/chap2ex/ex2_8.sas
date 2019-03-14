PROC FORMAT (DEFAULT=21);
PICTURE ZWDATE 
. - .z = "No Date Given"
LOW - HIGH = '%B %0d, %Y' (DATATYPE=DATE);
RUN;

PROC PRINT DATA=pictest LABEL;
VAR date date2;
FORMAT date worddate. date2 zwdate21.;
LABEL date = "Date Using WORDDATE."
date2 = "Date using ZWDATE.";
RUN;
