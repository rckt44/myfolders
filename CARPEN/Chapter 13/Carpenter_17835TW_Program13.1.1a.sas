* Program 13.1.1a.sas
* Listing the first N lines of a series of flat files;

%macro dumpit (cntout);
 %* create a local counter; 
 %local cwj;

 %do cwj=1 %to &numobs;

  %* fileref to identify the file to list;
  filename dump&cwj "&&invar&cwj"  disp=shr; 

  * read and write the first &cntout records;
  data _null_;
    infile dump&cwj end=done;
    * read the next record;
    input;
    incnt+1;
    if incnt le &cntout then list;
    if done then do;
       file print;
       put //@10 "total records for &&invar&cwj is "
             +2 incnt comma9. ;
    end;
  run;

  filename dump&cwj clear;

 %end;
%mend dumpit; * the macro definition ends;

* read the control file and establish macro variables;
data dumpit;
 infile cards;
 input filenam $25.;
 cnt+1;
 newname=trim(filenam);
 * the macro variable INVARi contains the ith file name;
 call symput ('invar'!!trim(left(put(cnt,3.))),newname); 
 * store the number of files to read;
cards; 
PNB7.QSAM.BANK.RECON
PNB7.QSAM.CHECKS
PNB7.QSAM.CHKNMBR
PNB7.QSAM.CKTOHIST
PNB7.QSAM.DRAIN
PNB7.QSAM.RECON
PNB7.BDAM.BDAMCKNO
PNB7.BDAM.VCHRCKNO
PNB7.QSAM.CS2V3120.CARDIN
PNB7.QSAM.CASVCHCK
PNB7.QSAM.CASVOUCH
PNB7.QSAM.VCHR3120.CARDIN
PNB7.QSAM.VOUCHERS
TAX7.JACKSON
;;;

title "City of Dallas - ECI (FINSYS), jobname is &sysjobid";
title2 "List of files to dump";
proc print data=dumpit;
run;

* Pass the number of records to dump from each file;
%dumpit (25);
