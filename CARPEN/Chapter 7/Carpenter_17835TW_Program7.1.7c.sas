* Program 7.1.7c.sas
* Understanding %SUPERQ references;

options symbolgen;
data _null_;
call symputx('pub','Fox&Hounds');
call symputx('hounds',' and &dogs');
call symputx('dogs','beagles');
run;

%put %superq(pub);
%put %superq(&pub);

%* Without embedded spaces;
data _null_;
call symputx('pub','Fox&Hounds');
call symputx('hounds','and&dogs');
call symputx('dogs','beagles');
call symputx('foxandbeagles', 'Hunt Day');
run;
%put %superq(&pub);
