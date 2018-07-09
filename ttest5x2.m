function accepted = ttest5x2(treatments, confidencelevel)
% accepted = ttest5x2(treatments, confidencelevel)
% each treatment is stored in one column.
% Makes 5x2 cv t test. H0: m1=m2
% If H0 accepted, function returns 1, 0 otherwise
rows = size(treatments,1);
difference = treatments(:,1)-treatments(:,2);
for i=1:rows/2,
  means(i)=(difference(2*i-1)+difference(2*i))/2;
  variance(i)=(difference(2*i-1)-means(i)).^2+(difference(2*i)-means(i)).^2;
end
denom = sqrt(sum(variance)/5);
statistic= difference(1)/denom;
threshold = tdistinv((1 - confidencelevel) / 2, rows/2);
if statistic>-threshold && statistic<threshold,
  accepted = 1;
else
  accepted = 0;
end    