* Program 7.6.2a.sas
* Calculating permutations and factorials;

%macro perm(n,r);
   %if &r ne %then %sysfunc(perm(&n,&r));
   %else %sysfunc(perm(&n));
%mend perm;
