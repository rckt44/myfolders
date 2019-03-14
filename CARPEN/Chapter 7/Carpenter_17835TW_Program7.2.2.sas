* Program 7.2.2.sas
* Using the %LENGTH to count trailing blanks;

%let b1 = x          x;
%let lenb1 = %length(&b1);
%let b2 = %qsubstr(&b1,1,&lenb1-1);
%let lenb2 = %length(&b2);
%put b1 |&b1| &lenb1;
%put b2 |&b2| &lenb2;
