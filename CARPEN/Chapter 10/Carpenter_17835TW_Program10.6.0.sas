* Program 10.6.sas
* Displaying macro code in the log;

data _null_;
  infile sasautos('ds2csv.sas');
  input;
  put _infile_;
run;
