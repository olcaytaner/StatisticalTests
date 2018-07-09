function criticalvalue=qdistinv(p, v, r)
%critical value = qdistinv(p, v, r)
%Returns the critical value of studentized range distribution with probability value of p and 
%with degree of freedoms v and r.
pcut=0.001;
jmax=8;
q1=qtrng0(p,v,r);
p1=qdist(q1,v,r);
criticalvalue=q1;
if abs(p1-p)<pcut,
  return
end  
if p1>p,
  p2=1.75*p-0.75*p1;
%  p1=1.75*p-0.75*p1;  
else
  p2=p+(p-p1)*(1-p)/(1-p1)*0.75;
end  
if p2<0.80,
  p2=0.80;
else
  if p2>0.995,
    p2=0.995;
  end
end    
q2=qtrng0(p2,v,r);
for j=2:jmax,
  p2=qdist(q2,v,r);
  e1=p1-p;
  e2=p2-p;
  criticalvalue=(e2*q1-e1*q2)/(e2-e1);
  if abs(e1)>=abs(e2),
    q1=q2;
    p1=p2;
  end
  if abs(p1-p)<5*pcut,
    return
  end   
  q2=criticalvalue;
end