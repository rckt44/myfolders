* Program 8.1.1e.sas
* Viewing current environmental variables under Windows;

options noxwait;
%sysexec set > c:\temp\environvar.txt;

* The X statement could also be used.;
x set > "c:\temp\environvar.txt";
