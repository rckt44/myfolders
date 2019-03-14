%* Program A1.5.10
%* Question #10
%* Modify %ALLYR to allow years from 1990 to the present
%* incoming data will have the four digit years in the name;

%macro allyr(start=2004,stop=2005);
   %do year = &start %to &stop;
      data temp;
         set yr&year;
         retain year &year;
         run;
      proc datasets lib=work nolist;
         append base=allyear data=temp;
         quit;
    %end;
%mend allyr;

%macro makedat;
%do i = 1998 %to 2003;
   data yr&i;
      do dummy = 1 to 3;
         output yr&i;
      end;
      run;
%end;
%mend makedat;
%makedat
%allyr(start=1999, stop=2002)

