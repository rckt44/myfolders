filename init "/folders/myfolders/kklick.txt";

data readit;
length Error $ 200.;
infile init truncover;
input all $ 200.;
if upcase(substr(all,1,5))='KANCH' then Error='yes';
else Error='No Error'; 
run;

data geterr;
set readit;
if compress(upcase(Error))='YES';
RUN;

data _null_;
set geterr;
call symputx('err',all);
run;

%put &=err;

/* call this macro in your email output */












