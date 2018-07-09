function accepted = anova(treatments, confidencelevel)
% accepted = anova(treatments, confidencelevel)
% each treatment is stored in one column.
% Makes one way anova test. H0: m1=m2=...=mk
% If H0 accepted, function returns 1, 0 otherwise
[rows, columns] = size(treatments);
meansquareerror = mse(treatments);
totalstandarderror = mst(treatments);
acceptprob = fdist(totalstandarderror / meansquareerror, columns-1, (rows - 1) * columns);
if acceptprob > confidencelevel 
  accepted = 1;
else
  accepted = 0;
end  
end