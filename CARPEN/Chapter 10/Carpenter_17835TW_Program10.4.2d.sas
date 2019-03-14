* Program 10.4.2d.sas
* Using MAUTOLOCINDES;

options nomautolocdisplay nomautocomploc;
options mautolocindes;

%put %lowcase(ALL UPPER);
title 'Program 10.4.2d Using MAUTOLOCINDES';
%macro getautopath(macname=left);
proc sql noprint;
select objdesc
   into :macpath
   from dictionary.catalogs
      where libname='WORK' & memname='SASMACR' & objname="%upcase(&macname)";
quit;
%mend getautopath;

%let macpath = ;
%put |%qtrim(string    )|;
%getautopath(macname=qtrim)
%put qtrim &macpath;

/** SQL can also be used to recover the path information;*/
/*proc sql ;*/
/*select libname, memname, objname, objdesc*/
/*   from dictionary.catalogs*/
/*      where libname='WORK' & memname='SASMACR';*/
/*quit;*/
   
/** You can also see the description this way;*/
/*proc catalog cat=work.sasmacr;*/
/*   contents;     */
/*   quit;*/
