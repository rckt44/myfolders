* Program 5.1.1
* Passing Subject number and debugging options
* between macros.;

%macro precomp(subject=,no=no);
options &no.mprint &no.symbolgen &no.mlogic;

... code not shown ...

* Create the location data set;
%locate(subject=&subject,no=&no)

... code not shown ...

%mend precomp;

%macro locate(subject=, no=no);
options &no.mprint &no.symbolgen &no.mlogic;

... code not shown ...

%mend locate;
 


