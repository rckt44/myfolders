PROC FORMAT;
PICTURE rptdate (DEFAULT=43)
 . - .Z = 'Missing'
LOW-HIGH = 'Generated on %B %d, %Y at %I:%0m %p' (DATATYPE=DATETIME);
RUN;

DATA _NULL_;
CALL SYMPUTX('RPTDTM',PUT(DATETIME(),RPTDATE.));
RUN;
FOOTNOTE "&RPTDTM";