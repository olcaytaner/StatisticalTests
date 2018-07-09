function meansquareerror = mse(treatments)
%meansquareerror = mse(treatments)
%calculates total mean square error of the treatments
[rows, columns] = size(treatments);
meanvector = mean(treatments);
sse = 0;
for i=1:rows,
  temp = treatments(i,:)-meanvector;
  sse = sse + sum(temp.^2);
end
meansquareerror = sse/(rows*columns-columns);  