LIBNAME ch6 'chap6ex';
/* Basic graph over time */

TITLE "Johnny's 50th Birthday Fund";
PROC GPLOT DATA=ch6.graph1;
PLOT fund*date / VREF=5000 LV=1 CV=blue;
RUN;

/* Format date - graph not very good */
TITLE "Johnny's 50th Birthday Fund";
PROC GPLOT DATA=ch6.graph1;
PLOT fund*date / VREF=5000 LV=1 CV=blue;
FORMAT date mmddyy10.; /* Add FORMAT statement */
RUN;

/* Define horizontal axis instead of letting SAS choose */
TITLE "Johnny's 50th Birthday Fund";
PROC GPLOT DATA=ch6.graph1;
PLOT fund*date / VREF=5000 LV=1 CV=blue 
                 HAXIS='01SEP1975'd TO '01SEP2015'd by YEAR;
FORMAT date mmddyy10.;
RUN;

/* Use shifted decade interval */

TITLE "Johnny's 50th Birthday Fund";
PROC GPLOT DATA=ch6.graph1;
PLOT fund*date / VREF=5000 LV=1 CV=blue 
                 HAXIS='01SEP1975'd TO '01SEP2015'd by YEAR10.69;
FORMAT date mmddyy10.;
RUN;
