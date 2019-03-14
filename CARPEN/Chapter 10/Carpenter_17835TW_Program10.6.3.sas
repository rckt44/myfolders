* Program 10.6.3
* Using the %CMPRES function;

%let text = %str(   The   quick  brown  fox  jumped  over   the  lazy   dog  );
%put text= |&text|;
%put text= |%cmpres(&text)|;

data _null_;
  infile sasautos('qcmpres.sas');
  input;
  put _infile_;
run;
