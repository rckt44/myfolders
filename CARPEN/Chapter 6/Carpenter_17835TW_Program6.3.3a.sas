* Program 6.3.3a
* Using RESOLVE in a DATA step VIEW;

data partial/view=partial;
   set macro3.clinics;
   where wt lt input(resolve('&wt'),6.); 
   *where wt lt input(symget('wt'),6.); 
   run;

%let wt=100;
proc print data=partial;
   var lname fname ht wt;
run;
