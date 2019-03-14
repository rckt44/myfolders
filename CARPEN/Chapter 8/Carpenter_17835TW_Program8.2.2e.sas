* Program 8.2.2e.sas
* Using %RETURN to terminate macro execution;

%macro modfem(dsn);
   %* Execute only for Females;
   %if &dsn ne FEMALE %then %return;
   data &dsn;
      set &dsn;
      wt = wt*2.2;;
      run;
%mend modfem;
%modfem(MALE)
