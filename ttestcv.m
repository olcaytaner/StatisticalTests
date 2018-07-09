function accepted = ttestcv(treatments, confidencelevel)
% accepted = ttestcv(treatments, confidencelevel)
% each treatment is stored in one column.
% Makes k-fold crossvalidated paired t test. H0: m1=m2
% If H0 accepted, function returns 1, 0 otherwise
rows = size(treatments,1);
difference=treatments(:,1) - treatments(:,2);
mdiff = sum(difference)/rows;
total = sum((difference-mdiff).^2);
variance = sqrt(total/(rows-1));
statistic = (sqrt(rows)*mdiff)/variance;
threshold =  tdistinv((1 - confidencelevel) / 2, rows-1);
if statistic < threshold && statistic > -threshold,
  accepted = 1;
else
  accepted = 0;
end    