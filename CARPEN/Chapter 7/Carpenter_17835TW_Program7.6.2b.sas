* Program 7.6.2b.sas
* Calculating permutations and factorials;

%macro perm(n,r);
   %* Check for improper values;
   %*   N & R must be positive integers;
   %*   N must be > R when R is provided;
   %* Calculate the factorial when R is not provided;
   %if &r ne %str() %then %do;
      %if %sysevalf(%sysevalf(&n,integer) ne &n)
         or %sysevalf(&n < 1)
         or %sysevalf(%sysevalf(&r,integer) ne &r)
         or %sysevalf(&r < 1)
         or %sysevalf(&r > &n) %then .;
      %else %sysfunc(perm(&n,&r));
   %end;
   %else %sysfunc(perm(&n));
%mend perm;

%* Shows Factorial for a single argument;
%put perm5! %perm(5);
%put perm3!  %perm(3,);

%* Permutations of 3 things taken 2 at a time;
%put perm3X2 %perm(3,2);

%put perm3.3X1 %perm(3.3,1);

%put perm5X2 %perm(5,2);

%put perm5X2 %perm(5,-2);
