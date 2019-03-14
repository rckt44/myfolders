* Program 5.4.2b
* Demonstrate scope and macro
* variable collisions;

%macro allyr3(start=,stop=);
     %let year=&start;
     %do %until(&year > &stop);
       data temp;
         set yr&year;
         year = 2000 + &year;
         run;
       proc datasets lib=work nolist;
         append base=allyear data=temp;
         quit;
       %let year = %eval(&year + 1);
     %end;
%mend allyr3;
%let year = FRED;
%put The global value of year is &year;
%allyr3(start=12, stop=14)
%put The global value of year is &year;


