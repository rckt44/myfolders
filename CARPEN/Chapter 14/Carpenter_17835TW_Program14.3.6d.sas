* Program 14.3.6d.sas
* Macro variable collisions in a %DO loop.;

%macro primary;
   /* ...code not shown...*/
   %do i = 1 %to &dsncnt;
      %chksurvey(&&dsn&i)
   %end;
   /* ...code not shown...*/
%mend primary;

%macro chksurvey(dset);
   %do i = 1 %to 5;
      /* ...code not shown...*/
   %end;
%mend chksurvey;
