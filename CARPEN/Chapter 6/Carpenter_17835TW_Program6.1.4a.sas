* Program 6.1.4a
* Creating a numbered list;
%macro lstnames;
%local i;
proc sort data=macro3.clinics(where=(lname=:'S'))
          out=clinics;
   by lname fname;
   run;

data _null_;
   set clinics end=eof;
   by lname;
   if first.lname then do;
      cnt+1;
      call symputx(catt('name',cnt),lname,'l');
   end;
   if eof then call symputx('nameN',cnt,'l');
   run;

%do i = 1 %to &namen;
   %put &&name&i;
%end;
%mend lstnames;
%lstnames
