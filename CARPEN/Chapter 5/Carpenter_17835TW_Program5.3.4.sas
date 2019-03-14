* Program 5.3.4
* Using %DO %WHILE;

%macro allyr4(start=,stop=);
     %let year=&start; 
     %do %while(&year <= &stop);
        data temp;
           set yr&year;
           year = 2000 + &year;
           run;
        proc datasets lib=work nolist;
           append base=allyear data=temp;
           quit;
        %let year = %eval(&year + 1);
     %end;
%mend allyr4;
%allyr4(start=12, stop=14)
