* Program 10.6.9.sas
* Surfacing autocall macros;

%macro listsas(f_ref=);
%local cdloc loccnt i;
%let cdloc = %sysfunc(pathname(&f_ref));
%let cdloc = %sysfunc(translate(&cdloc,%str( ),%str(%(),
                                       %str( ),%str(%)),
                                       %str( ),%str(%')));
%let cdloc = %sysfunc(tranwrd(&cdloc,%str(o   C:),%str(o__C:)));
%let loccnt = %sysfunc(count(&cdloc,%str(c:),i));

data ListSAS(keep=f_macname macname);
   length fname $250 f_macname macname $32;
   %do i = 1 %to &loccnt;
      done=0;
      length filein&i $250;
      fname=' ';
      do until(done);
         infile "%qscan(&cdloc,&i,%str(__))\*.sas" 
               filename=filein&i truncover
               end=done lrecl= 1000 dlm= ' (/)% ; ';
         input @;
         fname=filein&i;
         f_macname = scan(fname,-2,'\.');
         pos = find(_infile_,'%macro ', 'i') ;
         if pos;
         input @(pos+6) macName $;
         output ListSAS;
      end;
   %end;
   stop;
   run;
%mend listsas;
%listsas(f_ref=sasautos)
