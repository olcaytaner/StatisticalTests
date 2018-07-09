function accepted = tukey(treatments, confidencelevel)
% accepted = tukey(treatments, confidencelevel)
% each treatment is stored in one column.
% Makes tukey test. H0: m1=m2
% If H0 accepted, function returns 1, 0 otherwise
meanvector = mean(treatments);
rows = size(treatments,1);
meansquareerror = mse(treatments);
addup = qdistinv(confidencelevel, 2 * rows - 2, 2) * sqrt((2 * meansquareerror) / rows);
if meanvector(1) - meanvector(2) - addup <= 0 && meanvector(1) - meanvector(2) + addup >= 0,
  accepted = 1;
else
  accepted = 0;
end  