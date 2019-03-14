* Program 12.2.2.sas
* Demonstrate all available styles;

title1 '12.2.2 Showing Styles in Excel';
%macro showstyles;
%local i stylecnt;
proc sql noprint;
   select scan(style,2,'.') 
      into: style1-
         from sashelp.vstyle;
   %let stylecnt = &sqlobs; 
   quit; 

%do i = 1 %to 3;%*&stylecnt; %* Use &STYLECNT to show all styles;
ods tagsets.excelxp
         path="&path\chapter 12\Results"
         file="&&style&i...xls"
         style=&&style&i
         options(sheet_name="&&style&i"
                 sheet_interval="Proc"
                 embedded_titles='yes'                
/*                 doc='help'*/
                  );
%*put style is  &&style&i;
      title2 "Using the &&style&i Style"; 
      proc report data=sashelp.class; 
         column sex name age height weight;
         define sex    / order;
         define name   / display;
         define age    / analysis mean f=4.1;
         define height / analysis mean f=4.1;
         define weight / analysis mean f=5.1;
         break after sex / summarize suppress;
         rbreak after /summarize;
         run;
%end;
   ods tagsets.excelxp close;
%mend showstyles;
ods listing close;
%showstyles  
