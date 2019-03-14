* Program 5.4.1a
* Using macro comments;

%macro doit;
%* This macro does nothing of interest;
*  This macro variable &VAR remains unresolved;
/* Only the previous comment shows with MPRINT */
comment Old style COMMENT statement comments also appear in the LOG;
%mend doit;
%doit

%* Macro comment used in open code;
*  This macro variable &VAR remains unresolved;
/* Comment appears in the LOG */
