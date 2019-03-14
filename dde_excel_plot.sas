/***************************************************
	Using DDE to write on Excel sheet
****************************************************/

libname orion 'C:\Users\sanzp\Documents\sasprograms';

options noxwait noxsync;

/*Try not to use x command */
/*x '"C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"';*/
%sysexec "start excel";

data _null_;
rc=sleep(15);
run;
/*filename sas3xl dde "excel|[examples.xlsx]Sheet1!r1c1:r20c2";*/
filename example1 dde 'excel|sheet1!r1c1:r1c3' ;

/*data _null_;*/
/* file example1;*/
/* put [open("C:\Users\sanzp\Documents\sasprograms\housing.xls")];*/
/*run;*/


data _null_;
  file example1;
  x = "x";
  y = "y";
  z = "z";
  put x y z;
run;

filename example1 dde 'excel|sheet1!r2c1:r101c3' ;

data _null_;
   file example1;
   do i=1 to 100;
      x=ranuni(i);
      y=10+x;
      z=x-10;
      put x y z;
   end;
run;

filename example1 dde 'excel|sheet1!r1c4:r1c6' ;

data _null_;
  file example1;
  x = "x";
  y = "y";
  z = "z";
  put x y z;
run;

filename example1 dde 'excel|sheet1!r2c4:r20c6' ;

data _null_;
   file example1;
   do i=1 to 10;
      x=ranuni(i);
      y=10+x;
      z=x-10;
      put x y z;
   end;
run;

filename cmds dde 'excel|system';

data _null_;
rc=sleep(15);
run;

data _null_;
file cmds;
/* To save a .xls file */ 
put '[save.as("C:\Users\sanzp\Documents\sasprograms\house1.xls")]';
put '[SAVE()]';
put '[QUIT()]';
/* Insert an Excel Macro Sheet */
/*put '[workbook.insert(1)]';*/
/* change the name of the sheet */
/*put '[workbook.name("sheet1","NewSheet")]' */
;
run;

