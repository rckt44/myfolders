* Program 14.3.6e.sas
* Quiz on comments in a macro;
 
%macro abc;
   *%put in abc;  
%mend abc;

%macro doit;
   *%abc  
   %put here;
   *%let x = %abc; 
   %put value of x is &x;
%mend doit;
%doit   * run doit;  
