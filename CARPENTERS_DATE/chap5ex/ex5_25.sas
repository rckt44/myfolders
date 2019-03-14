/* Must run ex5_23.sas first */
DATA oops_intnx;
DO i=1 TO 8;
   function=CATS("INTNX('proddays','26dec2015'd,",put(i,1.),",'S');");
   result = INTNX('proddays','25dec2015'd,i,'S');
   OUTPUT;
END;
FORMAT result weekdate.;
DROP i;
RUN;

PROC PRINT DATA=oops_intnx;
RUN;
