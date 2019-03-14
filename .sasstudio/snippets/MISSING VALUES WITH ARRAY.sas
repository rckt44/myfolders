data want;
set sashelp.class;
run;

data need;
set want;
array hit (*) _numeric_;
call missing (count);
retain count 0;
do i=1 to dim(hit);
if not missing (hit(i)) then count+1;
if not missing (hit(i)) then hit(i)=0;
end;
run;




data testdata;                  
   input ch1 $ ch2 $ num1 num2 num3;      
   datalines;                      
aaa bbb 1 2 3             
. bbb 1 1 1               
. . . . .             
aaa bbb 1 1 1            
aaa bbb 1 . 2               
aaa . 1 1 .             
;    
run;


data nomiss;                    
   set testdata;    

/* Use the reserved word _NUMERIC_ to load all numeric variables  */
/* into the NUM array.  Use the reserved word _CHARACTER_ to      */ 
/* to load all character variables into the CHR array.            */

   array chr(*) _character_;      
   array num(*) _numeric_;   

/* Initialize COUNT to 0. */
   count=0; 

/* Increment COUNT when a non-missing value is found */
   do i = 1 to dim(chr);          
      if not missing(chr(i)) then count+1;
   end;                            
   do j = 1 to dim(num);           
      if not missing(num(j)) then count+1;     
   end;   

/* COUNT=0 indicates that all values are missing.  */
/* Delete the observation in this case. */ 
   if count>0 then delete; 
   drop i j count;   
run;
 
proc print;                     
run;  