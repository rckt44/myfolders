* Program 8.3.1a
* Show inter-relationship between &sysparm and the sysparm option;

%let sysparm=something;
options sysparm=' ';
%put &=sysparm;
%let sysparm=def;
data a;
   x = sysparm();
   y = getoption('sysparm');
   z = "&sysparm";
   put x= y= z=;
   run;
proc contents data=a;
   run;
