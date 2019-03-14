* Program 5.4.1c
* Asterisk-style comments can cause problems;

%macro allyr(start=10,stop=14);
   data allyear;
      set
      * The macro DO will generate the names;
      * of the incoming data sets;
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
