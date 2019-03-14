* Program 6.3.5b 
* Concatenating a list of values in the DATA step;

data _null_;
   set macro3.clinics(keep=lname) end=eof;
   length allnames $32767;
   retain allnames ' ';
   allnames = catx('|',allnames,lname);
   if eof then call symputx('lastnames',allnames);
   run;

