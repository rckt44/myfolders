* Program A1.7.7.sas
* Using the iterative %DO across the century boundary;

%macro makedat;
%do zz = 97 %to 99;
   data yr&zz;
      do dummy = 1 to 3;
         output yr&zz;
      end;
      run;
%end;
%do i = 0 %to 15;
   %let zz = &i;
   %if %length(&zz)=1 %then %let zz=0&zz;
   data yr&zz;
      do dummy = 1 to 3;
         output yr&zz;
      end;
      run;
%end;
%mend makedat;
%makedat

%macro allyr(start=04,stop=05);
/*   %* assume a two digit yearcutoff of 1920; */
/*   %*     (1920 is the default for SAS9.3) */
/*   %*     (1926 is the default for SAS9.4)*/
/*   %if &start <= 20 %then %let first = 2000 + &start;*/
/*   %else %let first = 1900 + &start;*/
/*   %if &stop <= 20 %then %let last = 2000 + &stop;*/
/*   %else %let last = 1900 + &stop;*/
   %local first last year yr;
   %* Use the current setting of the YEARCUTOFF option;
   %let first = %sysfunc(year(%sysfunc(mdy(1,1,&start))));
   %let last  = %sysfunc(year(%sysfunc(mdy(1,1,&stop))));
   %do year = &first %to &last;
      %* Create a two digit year;
      %let yr = %sysfunc(mod(&year,100),z2.);
/*      %* Test values;*/
/*      %put &=first &=last &=year &=yr;*/
      data temp;
         set yr&yr;
         year = &year;
         run;
      proc datasets lib=work nolist;
         append base=allyear data=temp;
         quit;
     %end;
%mend allyr;

%allyr(start=98, stop=11)
