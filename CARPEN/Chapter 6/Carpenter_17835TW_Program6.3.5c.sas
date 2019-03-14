* Program 6.3.5c 
* Using SYMGET and SYMPUTX to Concatenate a list of values in the DATA step;

%let lastnames=;
data _null_;
   set macro3.clinics(keep=lname);
   call symputx('lastnames',catx('|',symget('lastnames') ,lname);
   run;

%put &=lastnames;
