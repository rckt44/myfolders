* Program 5.3.2b
* Dynamically building code with the iterative %DO;

%macro allyr(start=10,stop=14);
   data allyear;
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
