function criticalvalue = zinverse(p)
%critical value = zinverse(p)
%Returns the critical value of standard normal distribution with probability value of p 
minz = -6.0;    
maxz = 6.0;     
zval = 0.0;       
if p <= 0.0 | p >= 1.0
  criticalvalue = 0.0;
  return
end  
while maxz - minz > 0.000001,
  pval = znormal (zval);
  if pval > p
    maxz = zval;
  else
    minz = zval;
  end  
  zval = (maxz + minz) * 0.5;
end
criticalvalue = zval;