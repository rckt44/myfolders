PROC FORMAT;
PICTURE wordmonth (DEFAULT=15)
LOW-HIGH = '%B %Y' (DATATYPE=DATE);
RUN;

DATA picdate;
INPUT date :mmddyy10.;
month_and_year = PUT(date,wordmonth.);
FORMAT date date11.;
DATALINES;
05/15/2016
08/01/2012
10/31/2013
03/27/2014
;
RUN;

PROC PRINT DATA=picdate NOOBS LABEL SPLIT='\';
label date="Original Date"
      month_and_year='Month and Year\Character Value'
;
RUN;
