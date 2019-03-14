DATA tricky3;
DO intervals= 0 TO 7;
   plain_interval_start = INTNX('YEAR10','01sep1950'd,intervals);
   shifted_interval_start = INTNX('YEAR10.65','01sep1950'd,intervals);
   OUTPUT;
END;
RUN;

PROC REPORT DATA=tricky3 NOWD SPLIT='\';
COLUMNS intervals plain_interval_start shifted_interval_start;
DEFINE intervals / DISPLAY "Number of\intervals from\September 1, 1950" 
       STYLE={CELLWIDTH=1in TEXTALIGN=C};
DEFINE plain_interval_start / FORMAT=weekdate32. 
       "Starting Date of YEAR10 Interval";
DEFINE shifted_interval_start / FORMAT=weekdate32.
       "Starting Date of Shifted YEAR10 Interval";
RUN;
