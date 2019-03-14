* Program 4.2.2b 
* Passing a List of Values;
%macro sortit(dsn,bylist);
    proc sort data=&dsn;
      by &bylist;
      run;
%mend sortit;



