DATA weekvalues;
INPUT @1 n @3 weeku weeku. @3 weekv weekv. @3 weekw weekw.;
FORMAT weeku weekv weekw weekdate.;
DATALINES;
1 W12
2 13W45
3 15W303
4 2014W2104
5 2015-W01-02
;
RUN;

PROC PRINT DATA=weekvalues NOOBS;
var n weeku weekv weekw;
RUN;
