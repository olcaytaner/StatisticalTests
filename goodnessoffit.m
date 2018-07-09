function accepted = goodnessoffit(treatments, confidencelevel)
% accepted = goodnessoffit(treatments, confidencelevel)
% observed examples are stored in the first column, expected example counts
% are stored in the second column
% Makes goodness of fit test. 
% H0: P(x is in group j) = pj for all j = 1,...,c
% If H0 accepted, function returns 1, 0 otherwise
[rows, columns] = size(treatments);
difference = treatments(:, 1) - treatments(:, 2);
sum = 0;
for i = 1:rows,
    sum = sum + (difference(i).^2) / treatments(i, 2)
end
accept = chiinv(1 - confidencelevel, rows - 1)
if sum < accept 
  accepted = 1;
else
  accepted = 0;
end  