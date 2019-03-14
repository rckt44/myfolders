LIBNAME ch6 'chap6ex';

/* The effect of the different values for the OBSERVED option of
   the CONVERT statement in PROC EXPAND on increased sample frequency  */ 

PROC EXPAND DATA=ch6.month OUT=seven1 FROM=MONTH TO=WEEK;
ID date;
CONVERT riders=beginning / OBSERVED=BEGINNING /*Default */;
RUN;
PROC EXPAND DATA=ch6.month OUT=seven2 FROM=MONTH TO=WEEK;
ID date;
CONVERT riders=middle / OBSERVED=MIDDLE;
RUN;
PROC EXPAND DATA=ch6.month OUT=seven3 FROM=MONTH TO=WEEK;
ID date;
CONVERT riders=end / OBSERVED=END;
RUN;
PROC EXPAND DATA=ch6.month OUT=seven4 FROM=MONTH TO=WEEK;
ID date;
CONVERT riders=total / OBSERVED=TOTAL;
RUN;
PROC EXPAND DATA=ch6.month OUT=seven5 FROM=MONTH TO=WEEK;
ID date;
CONVERT riders=average / OBSERVED=AVERAGE;
RUN;
PROC EXPAND DATA=ch6.month OUT=seven6 FROM=MONTH TO=WEEK;
ID date;
CONVERT riders=begend / OBSERVED=(BEGINNING,END);
RUN;
PROC EXPAND DATA=ch6.month OUT=seven7 FROM=MONTH TO=WEEK;
ID date;
CONVERT riders=avetot / OBSERVED=(AVERAGE,TOTAL);
RUN;

DATA compare_lo;
MERGE seven1 seven2 seven3 seven4 seven5 seven6 seven7;
BY date;
LABEL
   beginning="BEGINNING" middle = "MIDDLE" end = "END" average = "AVERAGE"
   total = "TOTAL" begend = "BEGINNING,END" avetot = "AVERAGE,TOTAL"
;;; 
FORMAT beginning--avetot 7.2; 
RUN;

PROC REPORT DATA=compare_lo NOWD SPLIT='\';
COLUMNS date ('OBSERVED=\Option Value' beginning middle end average total);
FORMAT date DATE9.;
DEFINE date / display;
WHERE DATE LT '01MAR2003'd;
RUN;

PROC REPORT DATA=compare_lo NOWD SPLIT='\';
COLUMNS date ('OBSERVED=\Option Value' begend avetot);
FORMAT date DATE9.;
DEFINE date / display;
WHERE DATE LT '01MAR2003'd;
RUN
