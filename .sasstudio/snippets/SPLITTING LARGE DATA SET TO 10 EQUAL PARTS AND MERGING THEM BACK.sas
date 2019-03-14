/* Hi all, */
/*   */
/* I have come across a situation where i need  */
/* to merge two transactional datasets. One DS has  */
/* about 500,000 observations and has ACCT_IND as primary key.  */
/* The second dataset B has about 750 million observations.  */
/* I need to merge these based on ACCT_IND. Can someone suggest  */
/* the best way to do it since if I merge them I will need to sort */
/*  the datasets first and if I join them using sql it will be very huge. */
/*  Can someone demonstrate a better method to do this */




data small;
input ACCT_IND $ name $;
datalines;
111 jon
123 bob
124 mary
451 lisa
333 sue
;
run;

data large;
input ACCT_IND $ sales;
datalines;
111 10
111 15
111 13
123 18
123 16
123 17
124 19
124 22
451 11
451 8
451 17
451 15
333 14
333 12
333 26
333 22
333 25
;
run;

proc contents data=sashelp.cars;
run;

*Number of records in large dataset;
%let records = 428; *750000000;
%put &=records;

*750 million record dataset - Split prior to merging to gain speed when merging;
data huge_dataset_0 huge_dataset_1 huge_dataset_2 huge_dataset_3 huge_dataset_4 huge_dataset_5 huge_dataset_6 huge_dataset_7 huge_dataset_8 huge_dataset_9;
set sashelp.cars;
if _n_ <= &records./10 then output huge_dataset_0;
else if _n_ <= 2/10*&records. then output huge_dataset_1;
else if _n_ <= 3/10*&records. then output huge_dataset_2;
else if _n_ <= 4/10*&records. then output huge_dataset_3;
else if _n_ <= 5/10*&records. then output huge_dataset_4;
else if _n_ <= 6/10*&records. then output huge_dataset_5;
else if _n_ <= 7/10*&records. then output huge_dataset_6;
else if _n_ <= 8/10*&records. then output huge_dataset_7;
else if _n_ <= 9/10*&records. then output huge_dataset_8;
else output huge_dataset_9;
run;

proc sort data = small;
by ACCT_IND;
run;

*Sort the large datasets and append the smaller dataset to each;
%macro sort(i);
proc sort data = huge_dataset_&i.;
by ACCT_IND;
run;

data large_&i.;
merge small ( in = a )
      huge_dataset_&i. ( in = b );
by ACCT_IND;
if b then output;
run;
%mend;

%sort(i=0); %sort(i=1); %sort(i=2); %sort(i=3); %sort(i=4); 
%sort(i=5); %sort(i=6); %sort(i=7); %sort(i=8); %sort(i=9);

*Bring the dataset back together;
data huge_dataset;
set large_0 large_1 large_2 large_3 large_4 
    large_5 large_6 large_7 large_8 large_9;
run;