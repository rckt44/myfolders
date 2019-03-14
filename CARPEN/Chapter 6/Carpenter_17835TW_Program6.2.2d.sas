* Program 6.2.2d
* Storing left justified numeric values;
proc sql noprint;
select height, weight
   into :ht, :wt 
      from sashelp.class
         where name='Alfred';
   quit;
%put |&ht|;
%put |&wt|;

proc sql noprint;
select height, weight
   into :ht separated by ' ', 
        :wt separated by ' ' 
      from sashelp.class
         where name='Alfred';
   quit;
%put |&ht|;
%put |&wt|;
