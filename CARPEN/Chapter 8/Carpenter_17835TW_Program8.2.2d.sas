* Program 8.2.2d.sas
* Using %GOTO to skip to the end of a macro;

%macro modfem(dsn);
   %* Execute only for Females;
   %if &dsn ne FEMALE %then %GOTO skip;
   data &dsn;
      set &dsn;
      wt = wt*2.2;;
      run;
   %skip:
%mend modfem;
%modfem(MALE)
