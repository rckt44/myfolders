PROC FORMAT;
VALUE exp 
LOW-'31DEC2013'd= "Expired"
'01JAN2014'd - HIGH=[ MMDDYY10.]; 
RUN;

PROC PRINT DATA=access;
ID card_num;
VAR exp_date exp_date_raw;
FORMAT exp_date exp. exp_date_raw DATE9.;
RUN;
