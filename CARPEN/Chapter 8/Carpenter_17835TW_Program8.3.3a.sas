* Program 8.3.3a
* Using the PARMBUFF switch;

%macro demo(a=1, b=2)/parmbuff;
  %put buffer holds |&syspbuff|;
  %put &=a;
  %put &=b;
%mend demo;

%demo(a=aa)

%demo(a=silly, d=unknown)

