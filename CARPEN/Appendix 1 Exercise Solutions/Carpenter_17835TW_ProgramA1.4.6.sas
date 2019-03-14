* Program A1.4.6
* Chapter 4 Question 6 solution;

%MACRO MYCOPY;

     PROC COPY IN=WORK  OUT=MASTER;
          SELECT PATIENTS;
     RUN;

%MEND MYCOPY; 

