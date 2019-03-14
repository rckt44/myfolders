data have;
x="Heart: Normal heart muscle colon (maximal wall thickness = 15mm). Normal aorta (maximal wall thickness = 1.6mm).
Lung: Normal lung (maximal wall thickness = 1.9mm), however movement is absent from the distal part.
Other: Reactive lymphadenopathy is seen . No complications of disease were noted.";


pid=prxparse('/(heart muscle|aorta|lung)[\w\s]+\([^\(\)]+\)/i');
pid1=prxparse('/(heart muscle|aorta|lung).+\s([\d\.]+mm)/i');
s=1;
e=length(x);
call prxnext(pid,s,e,x,p,l);
do while(p>0);
 want=substr(x,p,l);
 if prxmatch(pid1,want) then do;
  call prxposn(pid1,1,p1,l1);
  x1=substr(want,p1,l1);
  call prxposn(pid1,2,p2,l2);
  x2=substr(want,p2,l2);
 end;
 output;
 call prxnext(pid,s,e,x,p,l);
end;


drop pid s e p l pid1 p1 l1 p2 l2;
run;