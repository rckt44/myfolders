* Program 5.4.1b
* Using macro comments;

%macro allyr(start=10,stop=14);
   data allyear;
      * Include the data from the years of interest;
      * Use years from &start to &stop;
      set
      %do year = &start %to &stop;
            yr&year(in=in&year)
      %end;;
      year = 2000
      %do year = &start %to &stop;
           + (in&year*&year)
      %end;;
      run;
%mend allyr;
%allyr(start=11, stop=13)
