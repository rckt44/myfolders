* Program 12.4.2e.sas
* Create a list of unknown variable names
* that match a pattern;

/*----------------------------------------------------------
  NOTICE:
    This program is copyrighted by Michael Bramley, 2003. 
    All rights to this source code are retained. You may use
    and/or distribute this program as long as it 
    remains unaltered in any fashion or in any media.
    
  SYNOPSIS:
    This program contains a SAS macro function that will
    return a variable list from the specified dataset, where
    each variable name matches the "pattern", as described below.
    Note that within this macro and the following article
    "pattern" is defined to be a regular expression, as per
    SAS documentation. Moreover, each variable name is
    returned only once (even if it matches more than one pattern).

    For a thorough exposition of this macro, please refer to my
    SUGI 27 (37-27) article: Combining Pattern-Matching And File
    I/O Functions: A SAS Macro To Generate A Unique Variable
    Name List.

 
  Report any bugs, unexpected results, inconsistent behaviour
    or desired new behaviour to Michael Bramley
    (mbramley@cinci.rr.com) with the subject line of 
    BUILDVARLIST SAS MACRO.


  FILE: BuildVarList.sas

  AUTHOR: Michael Bramley
  WRITTEN: January 4, 2001
  UPDATED: March 8, 2003

  MACRO CALL:
    %BuildVarList( Dset, Type, Patterns )

  WHERE:
    Dset     = SAS data set to obtain variable information from,
    Type     = Type of variables to include in list 
              (N=numeric only, C=character only,
               or blank for all types),
    Patterns = |-separated list of zero or more patterns to use
               for selecting variable names (see below).

  NOTES:
This is a Macro Function, which means that it has a 
       return value of blank or a list of variable names 
       matching the pattern(s). As such, it can be used anywhere
       you would place a list of variable names, with the caveat
       that said usage includes blanks (in the case of no 
       variable names being returned).

Specifying Type=N or C and blank for Patterns will result
       in a list of all numeric or character variables,
       respectively, similar to the _Numeric_ or _Character
       keywords in a DATA step or procedure.

Leaving the Type and Patterns blank will cause the macro
       to return a list of all variable names in the data set. 

Case is only respected if the pattern is quoted, for
       example, 'VAR' matches all variable names beginning with
       uppercase VAR.

If more than one pattern is desired, then Patterns should
       be of the form:
       pattern-1|pattern-2|...|pattern-n. 
       The macro will process each pattern separately. Each
       pattern may be an expression containing (optionally)
       a prefix, asterisk, and/or suffix. The following case
       insensitive examples should help:

       Ex.1: DK*A will return all variable names that begin with
             DK and end with A,
       Ex.2: DK (or DK*) will return all variable names that 
             begin with DK,
       Ex.3: *A will return all variable names that end with
             A--the asterisk is required for this example.
 
  EXAMPLE:
    %Let MyVars = %BuildVar(TestData,,VAR) ;

    This assigns to the macro variable MyVar the value of a 
    Space-delimited list of all variable names that match the
    pattern "VAR*", regardless of type, where * may be 
    expanded into 0 to n characters. 
------------------------------------------------------------*/


%Macro BuildVarList( Dset, Type, Patterns ) ;
   /*
     Define local macro variables:
       VarList = list of variables matching pattern(s)
       VarName = name of current variable
       CurPat  = current pattern being used
       FID     = File IDentifier (for FILE I/O functions)
       RX      = Regular expression ID - SAS says "do not PUT..."
   */
   %Local VarList VarName CurPat FID RX I J ;

   /*
     Check Access to SAS data set.
   */
   %Let FID = %SysFunc( Open( &Dset ) ) ;
   %If Not &FID %Then %Do ;
       %Put ERROR: BuildVarList could not access &Dset.. ;
       %Go To Exit ;
   %End ;

   /*
     Check Type and Patterns. Default Type=NC to allow
     all variable types if none
     specified, otherwise validate Type.
   */
   %Let Type = %UpCase( &Type ) ; 

   %If "&Type" EQ "" %Then
       %Let Type = NC ;
   %Else
       %If Not %Index( NC, &Type ) %Then %Do ;
           %Put ERROR: BuildVarList found invalid variable type of &Type.. Must be blank, N, or C. ;
           %Go To Exit ;
       %End ;

   /* 
     If Version 6.xx engine, ensure that the Patterns parameter
     is uppercase.
   */
   %If %Index( %SysFunc( AttrC( &FID, ENGINE) ), V6 ) %Then
       %Let Patterns = %UpCase( &Patterns ) ;  

 
    /*
     If no Patterns specified, default to : to match all
     variables in data set.
   */
   %If "&Patterns" EQ "" %Then
       %Let Patterns = : ;

   /*
     BuildVarList Macro Main Processing Block: process
     patterns (separated by | <an or bar>) to generate
     variable list by calling SAS regular expression routines.

     NOTE: As some regular expressions may begin with SAS
           arithmetic operators, for example, + or *,
           it is imperative to quote them so that the SAS %Eval 
           function is not invoked in the %Do %While Loop.
   */
   %Let I = 1 ;
   %Let CurPat = %Scan( &Patterns, &I, | ) ;

   %Do %While( "&CurPat" NE "" ) ;
       %Let RX = %SysFunc( RXParse( &CurPat ) ) ; 
       /*
       If pattern accepted by parser, then process variables
       in SAS data set.
       */
       %If &RX %Then %Do ;
           %Do J = 1 %To %SysFunc( AttrN( &FID, NVARS ) ) ;
               /*
               If Type matches, check variable name against
               pattern and add the variable name to the list
               (if it is not already included).
               */
               %If %Index( &Type, %SysFunc( VarType( &FID, &J ) ) ) %Then %Do ;
                   %Let VarName = %SysFunc( VarName( &FID, &J ) ) ;
                   %If %SysFunc( RXMatch( &RX, &VarName ) ) And  
                       Not %Index( &VarList, &VarName ) %Then 
                           %Let VarList = &VarList &VarName ;
               %End ;
           %End ;

           %SysCall RXFree( RX ) ; 
   %End ;
   %Else 
       %Put WARNING: BuildVarList detected an invalid pattern ("&CurPat")...ignoring. ;

      %Let I = %Eval( &I + 1 ) ;
      %Let CurPat = %Scan( &Patterns, &I, | ) ;
   %End ;

   /*
     Did any variable names match any of the pattern(s) ?
   */
   %If Not %Length( &VarList ) %Then
       %Put WARNING: BuildVarList found no variable names in &Dset matching specified pattern(s). ;
 
%Exit:
   %If &FID %Then
       %Let RX = %SysFunc( Close( &FID ) ) ;

   &VarList
%Mend BuildVarList ;

/*
  Include a test data set...(ignore the warnings...)
*/
Data Test1 ;
   Length Var1-Var6 4 ;
   Length Var1RT Var2RT Var3RT Var4RT T1 - T10 4 ;
   Length Var1A Var1b Var1C VarRT T1R T2R T3R  $10 ;
Run ;

/*
  Test the BuildVarList macro function...
*/
%Put Character Only = %BuildVarList( Test1, C ) ;
%Put Numeric   Only = %BuildVarList( Test1, N ) ;
%Put  All Variables = %BuildVarList( Test1 ) ;
%Put Var* Variables = %BuildVarList( Test1, , Var ) ;
%Put VAR* Variables = %BuildVarList( Test1, , 'VAR' ) ; * VAR pattern does not exist;

*** End of BuildVarList Macro ;


%macro VList(dsn=, bylist=, id=, var=);
%global varlist;
*** create the transposed data set; 
proc sort data=&dsn(keep=&bylist &id &var)
          out=srtdata
          nodupkey;
   by &bylist &id;
   run;
proc transpose data=srtdata
               out=trnsdata(drop=_name_ _label_);
   by &bylist;
   id &id;
   var &var;
   run;
 
%let varlist=%buildvarlist(trnsdata,,shoe|dress);

%put &=varlist;
%mend VList;

%let varlist=;
%VList(dsn=sashelp.shoes, bylist=region subsidiary, id=product, var=sales)
