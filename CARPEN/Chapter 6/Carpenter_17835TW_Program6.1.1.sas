* Program 6.1.1
* Using SYMPUTX to assign a macro variable;
 
data _null_;
   * First argument variations;
   call symputx('dsn1','clinics-a');

   macvar='dsn1';
   call symputx(macvar,'clinics-b');

   n=1;
   call symputx('dsn'||left(put(n,12.)),'clinics-c');
   call symputx(catt('dsn',n),'clinics-d');

   * Second argument variations;
   call symputx('dsn1','clinics');

   dataset='clinics';
   call symput('dsn1',dataset);

   partname='clin';
   call symput('dsn1',catt(partname,'ics'));
run;
%put &=dsn1;

%macro princlin(clnum=123456);
data clin&clnum;
   set sasclass.clinics(where=(clinnum="&clnum")) 
       end=eof;
   if eof then call symputx('clname',clinname,'l');
   run;
title1 "Data for &clname";
proc print data=clin&clnum;
   var lname fname dob symp;
   run;
%mend princlin;
%princlin(clnum=057312)
