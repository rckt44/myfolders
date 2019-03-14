
* Program_Autoexec.sas;

* supply the  upper part of the path for whereever you 
* choose to put the files related to this book;
%let path=/folders/myfolders/CARPEN;
libname macro3 "&path";

********************for sql emp table***************;
 LIBNAME EMPTABLE '/folders/myfolders/EMPTABLE';
 proc import datafile="/folders/myfolders/EMPTABLE/EMP_TABLE.xlsx"
        out=EMPTABLE.emp
        dbms=xlsx
        replace;
    
     getnames=yes;
run;