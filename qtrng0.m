function prob=qtrng0(p, v, r)
vmax=120;
c1=0.8843;
c2=0.2368;
c3=1.214;
c4=1.208;
c5=1.4142;
t=zinverse(0.5+0.5*p);
if v<vmax,
  t=t+(t*t*t+t)/v/4;
end  
q=c1-c2*t;
if v<vmax,
  q=q-c3/v+c4*t/v;
end  
prob = t*(q*log(r-1)+c5);