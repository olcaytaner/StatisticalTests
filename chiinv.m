function criticalvalue=chiinv(p,freedom)
%critical value = chiinv(p, freedom)
%Returns the critical value of chi-square distribution with probability value of p and 
%with degree of freedom freedom.
minchisq = 0.0;
maxchisq = 99999.0;
if (p <= 0.0)
  criticalvalue = maxchisq;
  return
else
  if (p >= 1.0)
    criticalvalue = 0.0;
    return
  end
end    
chisqval = freedom / sqrt (p);    
while maxchisq - minchisq > 0.000001,
  if (chi(chisqval, freedom) < p)
    maxchisq = chisqval;
  else
    minchisq = chisqval;
  end  
  chisqval = (maxchisq + minchisq) * 0.5;
end
criticalvalue = chisqval;