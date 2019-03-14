DATA ex5_1;
INPUT row $ sasdate :date9. sastime :time8.;
result = DHMS(sasdate,0,0,sastime);
fmt_result = result;
FORMAT sasdate date9. sastime timeampm.;
DATALINES;
A 16oct2015 17:30
B 08jun2016 11:00
C 14apr2015 00:00
;
RUN;

PROC PRINT DATA=ex5_1 NOOBS LABEL SPLIT='\';
ID row;
VAR sasdate sastime result fmt_result;
FORMAT fmt_result datetime19. sasdate sastime;
LABEL row='Row'
result = '~{text_align=c}SAS Datetime Value\Calculated Using\DHMS(sasdate,0,0,sastime)'
fmt_result = "Result Formatted with\DATETIME19. Format";
RUN;
