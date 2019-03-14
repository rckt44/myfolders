* Program 6.2.3f
* Creating coordinated numbered lists in the DATA step;
proc summary data=macro3.clinics nway;
   class clinname;
   output out=cnt;
   run;
data _null_;
   set cnt;
   i+1;
   call symputx(catt('cname',i),clinname);
   call symputx(catt('ccnt',i),_freq_);
   call symputx('namecnt',i);
   run;

%put _user_;
