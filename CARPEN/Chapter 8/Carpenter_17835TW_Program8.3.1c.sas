* Program 8.3.1c
* Show that the length of the sysparm option is not limited to 200 characters;

%let a50=12345678901234567890123456789012345678901234567890;
%let sysparm=&a50&a50&a50&a50&a50&a50;
%put %length(&sysparm);
/*options sysparm=' ';*/
/*%put &=sysparm;*/
/*%let sysparm=def;*/
data a;
length x y z $500;
x = sysparm();
lx=length(x);
y = getoption('sysparm');
ly=length(y);
z = "&sysparm";
lz=length(z);
put x= y= z=;
put lx= ly= lz=;
run;
proc contents data=a;
run;
