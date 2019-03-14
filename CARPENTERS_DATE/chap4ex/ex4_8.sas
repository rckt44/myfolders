LIBNAME ch4 'chap4ex';

/* Select 10 records at random */
PROC SURVEYSELECT DATA=ch4.isoall (WHERE=(duration IS NOT MISSING)) OUT=ex4_8 (DROP=duration interval)
                    N=10 METHOD=SRS  NOPRINT SEED=32198765;
RUN;

DATA ex4_8;
SET ex4_8;
FORMAT aestdtm aeendtm $n8601e.;
RUN;

DATA circle;
SET ex4_8;
LENGTH duration $ 16 interval $ 32 start_dt $ 16 end_dt $ 16;
CALL IS8601_CONVERT('dt/dt','du',aestdtm,aeendtm,duration);
CALL IS8601_CONVERT('dt/dt','intvl',aestdtm,aeendtm,interval);
CALL IS8601_CONVERT('intvl','start',interval,start_dt);
CALL IS8601_CONVERT('intvl','end',interval,end_dt);
CALL IS8601_CONVERT('intvl','start',interval,start_dtNUM);
CALL IS8601_CONVERT('intvl','end',interval,end_dtNUM);
FORMAT duration interval start_dt end_dt $N8601E. start_dtNUM end_dtNUM datetime20.;
RUN;

OPTIONS ORIENTATION=LANDSCAPE;
ODS RTF FILE="example4.8.rtf";
PROC PRINT NOOBS DATA=circle;
ID aestdtm aeendtm;
VAR duration interval;
RUN;

PROC PRINT NOOBS DATA=circle;
ID aestdtm aeendtm;
VAR start_dt end_dt start_dtNUM end_dtNUM;
RUN;
ODS RTF CLOSE;
