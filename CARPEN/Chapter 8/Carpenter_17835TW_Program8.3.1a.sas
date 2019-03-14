* Program8.3.1a.sas
* Showing the difference between &sysparm and the SYSPARM function.;

/* Assume that  SAS is initiated with this execution line
"C:\Program Files\SASHome2\SASFoundation\9.4\sas.exe" -sysparm &aaa
*/

%let aaa = AAAAA;
data try2;
a = "&sysparm";
b = sysparm();
put a=;
put b=;
run;
