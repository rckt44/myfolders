* Program 8.1.1b.sas
* Using the %SYSGET function to retrieve an environmental variable
* that holds a libref;

* On the SAS.EXE line 
 -set tmp c:\temp
* ;

%put %sysget(tmp);

proc print data=tmp.oldtest;
run;

