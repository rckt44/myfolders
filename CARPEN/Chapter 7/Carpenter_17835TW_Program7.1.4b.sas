* Program 7.1.4b.sas
* Quoting before or after resolution;

%* The comma causes an error with %LEFT;
%let leftlist = %left(   height, weight);

%* A quoting function such as %STR prevents the error in %LEFT;
%let leftlist = %left(%str(   height, weight));
%let leftlist = %left(%bquote(  height, weight));

%* An error is generated even when the list is 
%* stored in a macro variable .;
%let list = height, weight;
%let leftlist = %left(   &list);

%* %STR will not work - the resolved value is not quoted
%* %STR acts before &LIST is resolved;
%let leftlist = %left(%str(&list));

%* Using %BQUOTE masks the resolved comma;
%* &LIST is resolved and the result is quoted;
%let leftlist = %left(%bquote(&list));
