DATA tricky;
DO intervals= 0 TO 5;
   plain_interval_start = INTNX('WEEK2','01jan2014'd,intervals);
   shifted_interval_start = INTNX('WEEK2.4','01jan2014'd,intervals);
   OUTPUT;
END;
RUN; 
PROC REPORT DATA=tricky NOWD SPLIT='\';
COLUMNS intervals plain_interval_start shifted_interval_start;
DEFINE intervals / "Number of WEEK2\intervals from\January 1, 2014"
       STYLE={CELLWIDTH=1.25in TEXT_ALIGN=C} DISPLAY;
DEFINE plain_interval_start /. "Starting Date of WEEK2 Interval"
       FORMAT=weekdate32.;
DEFINE shifted_interval_start / "Starting Date of WEEK2.4 Interval"
       FORMAT=weekdate32.;
RUN; 
