DATA sample211;
numeric_value = 18947;
fmt_num_value = 18947;
char_value = PUT(numeric_value,MMDDYY10.);
FORMAT fmt_num_value mmddyy10.;
LABEL numeric_value="SAS Date\Value"
      fmt_num_value="Formatted\SAS Date\Value"
      char_value="Character Date\in String";
RUN;

ODS RTF FILE="putfunction.rtf";

PROC PRINT DATA=sample211 NOOBS SPLIT='\'; 
RUN;
ODS RTF CLOSE;
