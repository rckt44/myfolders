DATA shiftind1;
LENGTH intvl $ 7;
intvl = "HOUR8";
fn = "INTNX('HOUR8','6:00't,0);";
start = INTNX('HOUR8','6:00't,0);
end = INTNX('HOUR8','6:00't,0,'E'); 
midnight = '6:00't;
OUTPUT;
DO i=1 TO 7;
   intvl = CATS('HOUR8.',put(i,1.));
   fn = CATS('INTNX(',intvl,",'6:00't,0)");
   start = INTNX(intvl,'6:00't,0);
   end = INTNX(intvl,'6:00't,0,'E');
   OUTPUT;
END;
FORMAT start end timeampm8.;
DROP i;
RUN;

DATA shiftind2;
LENGTH intvl $ 7;
intvl = "HOUR8";
fn = "INTNX('HOUR8','0:00't,0);";
start = INTNX('HOUR8','0:00't,0);
end = INTNX('HOUR8','0:00't,0,'E'); 
midnight = '0:00't;
OUTPUT;
DO i=1 TO 7;
   intvl = CATS('HOUR8.',put(i,1.));
   fn = CATS('INTNX(',intvl,",'0:00't,0)");
   start = INTNX(intvl,'0:00't,0);
   end = INTNX(intvl,'0:00't,0,'E');
   OUTPUT;
END;
FORMAT start end timeampm8.;
DROP i;
RUN;

DATA hour8;
DO i=0 TO 2;
   start = INTNX('hour8',"0:00"t,i);
   OUTPUT;
END;
FORMAT start timeampm.;
RUN;

PROC PRINT DATA=hour8;
RUN;

PROC REPORT DATA=shiftind1 NOWD SPLIT='\';
COLUMNS fn intvl start;
DEFINE fn / 'Function Call';
DEFINE intvl / "Interval Name";
DEFINE start / "Starting Time";
RUN;
 
DATA hour8_7;
DO i=0 TO 2;
   start = INTNX('hour8.7',"6:00"t,i);
   OUTPUT;
END;
FORMAT start timeampm.;
RUN;

PROC PRINT DATA=hour8_7;
RUN;
