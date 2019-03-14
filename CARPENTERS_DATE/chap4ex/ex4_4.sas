/* Doesn't work - incomplete data */
LIBNAME ch4 'chap4ex';
DATA ch4.aedtm;
INFILE "eventdata.txt" PAD MISSOVER DLM='09'x FIRSTOBS=2 DSD;
INPUT aestdtm :E8601DT. aeendtm :E8601DT.;
FORMAT aestdtm aeendtm datetime20.;
RUN;

/* ISO standard allows incomplete data */
/* SAS stores ISO date/time data as character - doesn't work with numeric format */
DATA ch4.aedtm2;
INFILE "eventdata.txt" PAD MISSOVER DLM='09'x FIRSTOBS=2 DSD;
INPUT aestdtm :$N8601B. aeendtm :$N8601B.;
FORMAT aestdtm aeendtm datetime20.;
RUN;

/* Don't use numeric format to make code work */
DATA ch4.aedtm2;
INFILE "eventdata.txt" PAD MISSOVER DLM='09'x FIRSTOBS=2 DSD;
INPUT aestdtm :$N8601B. aeendtm :$N8601B.;
RUN;

/* Calculate durations */
DATA ch4.iso_durations;
SET ch4.aedtm2;
LENGTH duration aedur $ 16;
CALL IS8601_CONVERT('dt/dt','du',aestdtm,aeendtm,duration);
aedur = duration;
FORMAT aedur $N8601E.;
RUN;

