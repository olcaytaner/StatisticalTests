function criticalvalue=fdistinv(p, freedom1, freedom2)
%critical value = fdistinv(p, freedom1, freedom2)
%Returns the critical value of F distribution with probability value of p and 
%with degree of freedoms freedom1 and freedom2.
maxf = 9999.0;     
minf = 0.0;       
if (p <= 0.0 | p >= 1.0)
  criticalvalue = 0.0;
  return
end  
fval = 1.0 / p;             
while (abs(maxf - minf)) > 0.000001,
  if fdist(fval, freedom1, freedom2)< p
    maxf = fval;
  else                              
     minf = fval;
  end   
  fval = (maxf + minf) * 0.5;
end
criticalvalue = fval;