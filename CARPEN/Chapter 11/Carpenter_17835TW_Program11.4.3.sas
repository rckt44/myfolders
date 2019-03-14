* Program 11.4.3.sas
* Processing a horizontal list;

options nomprint;
%macro prtclass(dset=sashelp.class, 
                classvar=sex, 
                prtcnt=10,
                tst=on);
   %local classlist classcnt j put;
   proc sql noprint;
      select unique &classvar
         into :classlist separated by '|'
            from &dset;
   %let classcnt = &sqlobs;
   quit;

   %if %upcase(&tst)=ON %then %let put=%nrstr(%put );
   %else %let put=;

   %do j = 1 %to &classcnt;
      %unquote(
      &put title1 "First &prtcnt obs of &classvar=%qscan(&classlist,&j,|)";
      &put proc print data=&dset(obs=&prtcnt);     
      &put    where &classvar = "%qscan(&classlist,&j,|)";
      &put run;
      )
   %end;
%mend prtclass;
%prtclass(dset=sashelp.class, classvar=sex, prtcnt=5, tst=on)
%prtclass(dset=sashelp.class, classvar=sex, prtcnt=5, tst=)

 
