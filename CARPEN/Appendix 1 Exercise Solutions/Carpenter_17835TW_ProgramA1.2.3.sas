* Program A1.2.3
* Chapter 2 Question 3 solution;

%let dsn=clinic;
%let lib=sasuser;
%let i=3;
%let dsn3 = studydrg;
%let b=dsn;

%put '&lib&dsn ' &lib&dsn;
%put '&lib.&dsn ' &lib.&dsn;
%put '&lib..&dsn ' &lib..&dsn;

%put '&dsn&i ' &dsn&i;
%put '&&dsn&i ' &&dsn&i;
%put '&dsn.&i ' &dsn.&i;

%put '&&bb ' &&bb;
%put '&&&b ' &&&b;

* Extra credit;
%put '&dsn..&&dsn&i ' &dsn..&&dsn&i;

