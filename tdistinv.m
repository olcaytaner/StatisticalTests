function criticalvalue=tdistinv(p,freedom)
%critical value = tdistinv(p, freedom)
%Returns the critical value of t distribution with probability value of p and 
%with degree of freedom freedom.
if (p<0.5)
  criticalvalue = sqrt(fdistinv(p*2,1,freedom));
else
  criticalvalue = -sqrt(fdistinv((1-p)*2,1,freedom));
end