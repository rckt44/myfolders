* Program 13.1.2.sas
* Save the date and/or time ;

%macro update(type=date);
  %global timestr datestr bothstr;
  %let timestr=;
  %let datestr=;
  %let bothstr=;
  %let type = %lowcase(&type);
  %if &type=all %then %let type=both;

  %if &type=date or &type=both %then
    %let datestr = %left(%qsysfunc(today(),worddate.));
  %if &type=time or &type=both %then
    %let timestr = %left(%sysfunc(time(),HHMM.));

  %if &type=both %then %let bothstr=&timestr._&datestr;
%mend update;
%update(type=date)
%put &=timestr &=datestr &=bothstr;
%update(type=time)
%put &=timestr &=datestr &=bothstr;
%update(type=both)
%put &=timestr &=datestr &=bothstr;
%update(type=all)
%put &=timestr &=datestr &=bothstr;
%update(type=fred)
%put &=timestr &=datestr &=bothstr;

