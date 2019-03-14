* Program 5.4.2a
* Demonstrate scope and macro
* variable availability;

%let outside = AAA; 

%macro one;
  %global inone; 
  %let inone = BBB;
%mend one;

%macro two;
  %let intwo = CCC; 
%mend two;

%macro last;
  %one 
  %two
  %put &outside &inone &intwo; 
%mend last;

%last

