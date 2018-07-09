function accepted = cochran(treatments, confidencelevel)
% accepted = anova(treatments, confidencelevel)
% each treatment is stored in one column.
% Makes cochran's test. H0: m1=m2=...=mk
% If H0 accepted, function returns 1, 0 otherwise
[rows, columns] = size(treatments);
rowsum = sum(treatments, 2);
columnsum = sum(treatments, 1);
grandtotal = sum(rowsum);
difference = columnsum - grandtotal / columns;
num = sum(difference.^2);
denom = sum(columns - rowsum);
statistic = (columns * (columns - 1) * num) / denom;
accept = chiinv(1 - confidencelevel, columns - 1);
if statistic < accept 
  accepted = 1;
else
  accepted = 0;
end  