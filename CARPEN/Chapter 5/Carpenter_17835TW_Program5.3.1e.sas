* Program 5.3.1e
* Using %DO to enclose code blocks;

%macro Tdataprep(style=new,
                 dsn=,
                 temp=,
                 maxage=,
                 regvar=);
%***********
* style  = new    Current data format
*          OLD    historical data form
* dsn    =        data set containing old style data
*                 data type for new data
* temp   =        testing temperature used to subset old data
* maxage =        maximum product age for old data
* regvar =        Test regression variable, used with new data
***********;

%* test for type of data and set up accordingly.;
%if &style=OLD %then %do;
   *  read the data for a specific test;
   proc sort data=old.&dsn out=tdata;
   by varno age;
   where temp=&temp & age le &maxage;
   run;
%end;
%else %do;
   data tdata (keep=varno canno temp age depvar test package);
   set cps.dest (keep=base no &regvar.1-&regvar.6 
                    temp test package);
   array can &regvar.1-&regvar.6;
   length age varno 8;
   where base="&dsn";

   ...code not shown...
   run;

   proc sort data=tdata;
   by varno age temp;
   run;
%end;
%mend tdataprep;
