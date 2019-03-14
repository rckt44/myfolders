LIBNAME control "chap3ex";
ODS ESCAPECHAR='~';
OPTIONS CMPLIB=(control.functions);

PROC FCMP OUTLIB=control.functions.dates;

FUNCTION makedate(cdate $)$;
  LENGTH dtstr $42
         supr   $16;
  supr=' ';
  * assume that date is in MMDDYY form, but check;
  * missing dates often have a form of __/__/____;
  IF SUBSTR(cdate,7,4) NOT IN (' ','____')  THEN DO;
     * assume year is good;
     yy=INPUT(SUBSTR(cdate,7,4),4.);
     m=SUBSTR(cdate,1,2);
     IF '01' <= m <= '12' THEN DO;
        mm=INPUT(m,2.);
       * Month is good chk day;
       * Use INTNX to find the maximum number of days in current month;
       d=SUBSTR(cdate,4,2);
       IF '01' <= d <= PUT(DAY(INTNX('MONTH',MDY(mm,1,yy),0,'e') ),z2.)
          THEN dd=INPUT(d,2.); 
       ELSE DO;
         * Day is bad for this month;
         * Fix by dividing number of days in month by 2;
         dd = CEIL(DAY(INTNX('MONTH',mdy(mm,1,yy),0,'e'))/2);
         supr = '~{super Day}';
       END;
     END;
     ELSE DO;
        * Month is bad - reset month and day;
        mm=6;
        dd=31;
        supr = '~{super Month}';
    END;
   * Create the date value;
     date=MDY(mm,dd,yy);
     dtstr = CATT(PUT(date,MMDDDYY10.),supr);
  END;
  ELSE DO;
    * yr is bad;
     dtstr = 'Unknown~{super Y}';
  END;
  RETURN(dtstr);
ENDSUB;
RUN;
QUIT;

PROC FORMAT;
   VALUE $mkdt
      OTHER=[makedate()];
RUN;

/* Sample Data */
DATA rptdates;
INPUT recno @4 rptdt $10. errs;
DATALINES;
1  13/15/2013 374
2  09/08/2013 3
3  02/30/2013 32
4  __/15/2013 15
5  04/27/2013 195
6  05/__/2013 17
7  07/08/____ 20
8  06/04/013 5
9  08/32/2013 4
10 11//2013   6
11 01/23/2031 11
;;;;
RUN;

/* Print out the result */

ODS _ALL_ CLOSE;
ODS RTF FILE='example3_7.rtf';
PROC REPORT DATA=rptdates NOWD SPLIT='\';
COLUMN rptdt rptdt=dt errs;
DEFINE rptdt / DISPLAY "Original  \Date from\Error Log";
DEFINE dt / 'Imputed\Date' f=$mkdt36.;
DEFINE errs / "Errors\Reported";
RUN; 
ODS RTF CLOSE;
