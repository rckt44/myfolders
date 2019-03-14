* Program 8.1.3.sas
* Determine if a macro has been compiled and / or is executing;

options sasmstore=macro3 mstored;

%macro one/store;
   %put in one;
   %two
%mend one;
%macro two;
   %put in two;
   %three
%mend two;
%macro three;
   %put in three;
   %macexec(one)
   %macexec(three)
   %macexec(silly)
%mend three;
%macro Macexec(macname);
   %if %sysmacexist(&macname) %then %put %upcase(&macname) exists in WORK.SASMACR;
   %else %put %upcase(&macname) does not exist in WORK.SASMACR;
   %if %sysmacexec(&macname) %then %put %upcase(&macname) is currently executing;
%mend macexec;
%one
