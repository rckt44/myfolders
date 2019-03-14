* Program A1.3.4
* Chapter 3 Question 4 solution
* Creating an autocall library;
* Assumes that the definition of the macro REPORTIT has been
* written to the location in the fileref MACLIB;

filename maclib "&path\Appendix 1 Exercise Solutions\SAS Programs";
options mautosource
        sasautos=(maclib, sasautos);

%let dsn = clinics;
%let var1 = edu;
%let var2 = sex;

%reportit

