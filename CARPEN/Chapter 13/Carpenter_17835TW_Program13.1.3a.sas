* Program 13.1.3a.sas
* Create a batch file that executes a series of SAS programs ;

%macro makerunbat(saspgmloc=c:\temp,batchloc=c:\);
   filename c1sas pipe "dir ""&saspgmloc\*.sas"" /o:n /b"; 

   data _null_;
      length saspgm $40  excmd $350;

      * read the names of the SAS programs;
      infile c1sas truncover;  
      input saspgm $40.;

      * Write out the batchfile into &batchloc;
      file "&batchloc\Program13.1.3a_runbat.bat";

      * Build the executable command;
      excmd = catt('"',"%sysget(sasroot)\sas.exe",
                   '" -sysin "', "&saspgmloc",
                   '\',saspgm,'"');
      put excmd;
   run;

%mend makerunbat;
%makerunbat(saspgmloc=&path\chapter 1\SAS Programs,batchloc=c:\temp)
