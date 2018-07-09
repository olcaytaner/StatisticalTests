function accepted = ftest5x2(treatments, confidencelevel)
% accepted = ftest5x2(treatments, confidencelevel)
% each treatment is stored in one column.
% Makes 5x2 cv f test. H0: m1=m2
% If H0 accepted, function returns 1, 0 otherwise
rows = size(treatments,1);
difference=treatments(:,1)-treatments(:,2);
diffsquare=difference.^2;
num = sum(diffsquare);
for i=1:rows/2,
  means(i)=(difference(2*i-1)+difference(2*i))/2;
  variance(i)=(difference(2*i-1)-means(i)).^2+(difference(2*i)-means(i)).^2;
end
denom = 2*sum(variance);
statistic = num/denom
rejectprob =1 - fdist(statistic, rows, rows/2);
if rejectprob < confidencelevel,
  accepted = 1;
else
  accepted = 0;
end    