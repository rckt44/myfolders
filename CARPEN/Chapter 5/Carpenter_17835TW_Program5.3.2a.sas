* Program 5.3.2a
* Using the iterative %DO;

%macro allyr(start=10,stop=15);
   %do year = &start %to &stop;
      data temp;
         set yr&year;
         year = 2000 + &year;
         run;
      proc datasets lib=work nolist;
         append base=allyear data=temp;
         quit;
     %end;
%mend allyr;

%macro makedat;
%do i = 6 %to 15;
   data yr&i;
      do dummy = 1 to 3;
         output yr&i;
      end;
      run;
%end;
%mend makedat;
%makedat
%allyr(start=12, stop=14)
%allyr(start=6, stop=9)

data temp;
   set yr12;
   year = 2000 + 12;
   run;
proc datasets lib=work nolist;
   append base=allyear data=temp;
   quit;

data temp;
   set yr13;
   year = 2000 + 13;
   run;
proc datasets lib=work nolist;
   append base=allyear data=temp;
   quit;

data temp;
   set yr14;
   year = 2000 + 14;
   run;
proc datasets lib=work nolist;
   append base=allyear data=temp;
   quit;

