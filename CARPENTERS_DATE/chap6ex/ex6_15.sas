PROC FORMAT;
PICTURE dbdate
LOW-HIGH = '%Y-%0m-%0d:%0H:%0M:%0S' (DATATYPE=DATETIME)
. - .Z = '0000-00-00:00:00:00';
RUN;

DATA _NULL_;
now = '01JUL2014:20:18:32'dt;
PUT "now displayed as datetime value: " @33 now;
PUT "now displayed as datetime19.: " @33 now DATETIME19.;
PUT "now displayed as dbdate.: " @33 now DBDATE.;
RUN;
