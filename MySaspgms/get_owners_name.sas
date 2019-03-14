
/* get file owners informations */
*source :https://stackoverflow.com/questions/12070533
/how-to-get-owners-information-for-sas-file-in-windows-sas;
data info;
   length infoname infoval $300;
   drop rc fid infonum i close;
   rc=filename('abc','C:\c-ae.sas');
   fid=fopen('abc');
   infonum=foptnum(fid);
   do i=1 to infonum;
      infoname=foptname(fid,i);
      infoval=finfo(fid,infoname);
      output;
   end;
   close=fclose(fid);
run;
