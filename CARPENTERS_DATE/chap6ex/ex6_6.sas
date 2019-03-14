LIBNAME ch6 'chap6ex';

/* Basic SGPLOT */

TITLE "Johnny's 50th Birthday Fund";
PROC SGPLOT DATA=ch6.graph1;
XAXIS TYPE=time;
SERIES X=date Y=fund;
RUN;

/* Basic SGPLOT with a format - Format not used by SAS when graph is created */
TITLE "Johnny's 50th Birthday Fund";
PROC SGPLOT DATA=ch6.graph1;
XAXIS TYPE=time;
SERIES X=date Y=fund;
FORMAT date monyy7.;
RUN;

/* SGPLOT with axis definition */
TITLE "Johnny's 50th Birthday Fund";
PROC SGPLOT DATA=ch6.graph1;
XAXIS TYPE=time VALUES=('01sep1975'd TO '01sep2015'd BY YEAR5);
SERIES X=date Y=fund;
FORMAT date monyy7.;
RUN;
