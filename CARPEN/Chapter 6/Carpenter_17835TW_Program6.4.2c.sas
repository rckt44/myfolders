* Program 6.4.2c
* Using data set variables to name macro variables.;

data null_;
   infile cards truncover;
   input ticker $ @16 company $55.;
   call symputx(ticker,company,'l');
   datalines;
   IBM         International Business Machines Corporation
   INTEL       Intel Corporation
   Microsoft   Microsoft Corporation
   run;

data stocks;
   set sashelp.stocks(keep=stock date volume);
   length CorpName $55;
   CorpName = symget(stock);
   run;
