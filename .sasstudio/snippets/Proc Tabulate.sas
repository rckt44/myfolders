


proc tabulate data=sashelp.cars out=a;
class origin make ;
/* whatever vars you want to have in table statement, */
/* you must have in class statement,its a classificaton variable */
var msrp invoice;
/* in var statement ,you must put what numeric calculations */
/* you want to have */
 table make,(origin*msrp)(origin*invoice) ; 
/*  whatever variable you want to put on rows/left side of the table, */
/*  you put the left most side of the table statement */
table make,(origin*msrp)invoice all;
/* yo aestrik le k bhitra k bhanne bujaucha,jasto ki  */
/* origin bhitra msrp ,arko exampe chai jasto proc freq ma */
/* table origin*make garyo bhane origin bhitra ko make ko count le  */
/* bhanne bujaucha,ho testai ho eha pani */
/* 'all' will produce the totol freq count for your left side of table vars */
/* i.e Make  */
/* and if you don't specify your top of var which is origin with invoice
like this (origin*invoice) 
then invoice will be default sum for all as well */
/* whatever vars you want on top of table,you put after comma */
table make,origin*(msrp invoice);
run;


proc transpose data=a;
id make;
var make;
by ;
run;