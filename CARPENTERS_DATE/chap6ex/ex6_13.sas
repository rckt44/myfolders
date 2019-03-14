LIBNAME ch6 'chap6ex';
/* The effect of the different values for the OBSERVED option of
   the CONVERT statement in PROC EXPAND with a decreased sample frequency  */ 
PROC EXPAND DATA=ch6.month OUT=annual1 FROM=MONTH TO=YEAR;
ID date;
CONVERT riders=beginning / OBSERVED=BEGINNING /*Default */;
RUN;
PROC EXPAND DATA=ch6.month OUT=annual2 FROM=MONTH TO=YEAR;
ID date;
CONVERT riders=middle / OBSERVED=MIDDLE;
RUN;
PROC EXPAND DATA=ch6.month OUT=annual3 FROM=MONTH TO=YEAR;
ID date;
CONVERT riders=end / OBSERVED=END;
RUN;
PROC EXPAND DATA=ch6.month OUT=annual4 FROM=MONTH TO=YEAR;
ID date;
CONVERT riders=total / OBSERVED=TOTAL;
RUN;
PROC EXPAND DATA=ch6.month OUT=annual5 FROM=MONTH TO=YEAR;
ID date;
CONVERT riders=average / OBSERVED=AVERAGE;
RUN;
PROC EXPAND DATA=ch6.month OUT=annual6 FROM=MONTH TO=YEAR;
ID date;
CONVERT riders=begend / OBSERVED=(BEGINNING,END);
RUN;
PROC EXPAND DATA=ch6.month OUT=annual7 FROM=MONTH TO=YEAR;
ID date;
CONVERT riders=avetot / OBSERVED=(AVERAGE,TOTAL);
RUN;

DATA compare_hi;
MERGE annual1 annual2 annual3 annual4 annual5 annual6 annual7;
BY date;
LABEL
   beginning="BEGINNING" middle = "MIDDLE" end = "END" average = "AVERAGE"
   total = "TOTAL" begend = "BEGINNING,END" avetot = "AVERAGE,TOTAL"
;;; 
FORMAT beginning--avetot 11.2; 
RUN;

PROC REPORT DATA=compare_hi NOWD SPLIT='\';
COLUMNS date ('OBSERVED=\Option Value' beginning middle end average total);
FORMAT date YEAR4.;
DEFINE date / display;
RUN;

PROC REPORT DATA=compare_hi NOWD SPLIT='\';
COLUMNS date ('OBSERVED=\Option Value' begend avetot);
FORMAT date YEAR4.;
DEFINE date / display;
RUN;
