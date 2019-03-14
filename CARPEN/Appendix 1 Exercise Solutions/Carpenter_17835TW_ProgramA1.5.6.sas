* Program A1.5.6
* Question #6
* Generic PROC step;

%macro genproc(proc=,dsn=,varlst=);
   title1 "&proc Procedure for &dsn";
   proc &proc data=&dsn;
      var &varlst;
      run;
%mend genproc;

%genproc(proc=means,dsn=macro3.clinics, varlst=edu ht wt)
%genproc(proc=univariate,dsn=macro3.clinics, varlst=edu ht wt)
