* Program 4.3.3 
* Documenting your macro;
%macro schoen2(data   =  ,
               event  = status,
               outsch = schr,
               outbt  = schbt,
               vref   = yes,
               points = yes,
               df     = 4,
               alpha  = .05,
               rug    = no ,
               no     = no );
******************************************* 
* Macro parameters with default values.
data   =  ,       name of the analysis data set.
event  = status,  event variable for survival status at exit, 
                    1=event, 
                    0=censored, currently named STATUS
outsch = schr,    name of output data set containing Schoenfeld
                  residuals.
outbt  = schbt,   name of output data set containing the scaled 
                  Schoenfeld residuals(Bt).
vref   = yes,     indicator to control plotting of a vertical 
                  reference line at y=0. Values are yes(default) 
                  and no.
points = yes,     Indicates whether to plot the actual data points. 
                  Default is yes.
df     = 4,       degrees of freedom for smoothing process. 
                  Possible (integral)values are 3 to 7.  
                  Default is 4.
alpha  = .05,     Confidence coefficient for plotting standard 
                  error bars.  Default is .05.
rug    = no       indicator to control plotting of rug of x values.
no     = no       Turn on and off macro debugging
                    no    debugging is off
                    blank debugging is on
**************************************************************;
OPTIONS &no.symbolgen &no.mprint &no.mlogic;
%put *** Entering SCHOEN2 macro ***;

/*...code not shown...*/

%put *** Leaving SCHOEN2 macro ***;
%mend schoen2;
