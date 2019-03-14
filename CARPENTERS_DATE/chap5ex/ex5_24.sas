/* Must run ex5_24.sas first */

DATA oops_intck;
DO i=1 TO 15;
   startDate = '23dec2015'd;
   endDate = '23dec2015'd+i;
   result = INTCK('proddays',startDate,endDate);
   FORMAT startDate endDate weekdate.;
   OUTPUT;
END;
DROP i;
RUN;

PROC PRINT DATA=oops_intck;
RUN;
