* Program 8.3.3b
* Using the PARMBUFF switch;

%macro test/pbuff;
  %put &syspbuff;
  %put %symexist(syspbuff);
  %put %symglobl(syspbuff);
  %put %symlocal(syspbuff);
%mend test;
%test(abc)
%put &=syspbuff;



*Proves to be local;
%macro test/pbuff;
%put &syspbuff;
%put _automatic_;
%mend test;
%macro outer/pbuff;
%put &syspbuff;
%test(abc)
%put &syspbuff;
%mend outer;
%outer(def)



