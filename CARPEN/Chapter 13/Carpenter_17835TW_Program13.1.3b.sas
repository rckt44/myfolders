* Program 13.1.3b.sas
* Create a batch file that inclues a series of SAS programs for execution;

%macro makerunbat2(saspgmloc=c:\temp,batchloc=c:\);
   filename c1sas pipe "dir ""&saspgmloc\*.sas"" /o:n /b"; 

   data _null_;
      length saspgm $40  excmd $350;

      * Build the master batch pgm;
      if _n_=1 then do;
         * Write out the batchfile into &batchloc;
         file "&batchloc\Program13.1.3b_runbat.bat";

         * Build the executable command;
         excmd = catt('"',"%sysget(sasroot)\sas.exe",
                      '" -sysin "', "&batchloc",
                      '\Program13.1.3b_Masterpgm.sas"');
         put excmd;
      end;

      * read the names of the SAS programs;
      infile c1sas truncover;  
      input saspgm $40.;
         * Write the INCLUDE statements into the master program;
         file "&batchloc\Program13.1.3b_Masterpgm.sas";

         * Build the INCLUDE statement to be written to the master;
         excmd = cat('%include ', 
                      quote(catt("&saspgmloc",
                                  '\',
                                 saspgm)));
         put excmd;
   run;
%mend makerunbat2;
%makerunbat2(saspgmloc=&path\chapter 1\SAS Programs,batchloc=c:\temp)
