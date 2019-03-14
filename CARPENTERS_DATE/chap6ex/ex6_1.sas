TITLE "This is how to put a macro variable in a title: Today's Date is &SYSDATE9";
PROC PRINT DATA=sashelp.company (OBS=5);
ID job1;
VAR depthead;
RUN;
