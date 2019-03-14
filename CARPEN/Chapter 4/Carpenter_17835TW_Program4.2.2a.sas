* Program 4.2.2a 
* Defining the Macro %SORTIT;
%macro sortit(dsn,by1,by2,by3);
    proc sort data=&dsn;
      by &by1 &by2 &by3;
      run;
%mend sortit;

