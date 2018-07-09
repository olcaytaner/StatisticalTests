function accepted = signtest(plus, minus, confidencelevel)
% accepted = signtest(plus, minus, confidencelevel)
% Makes sign test. H0: plus = minus
% If H0 accepted, function returns 1, 0 otherwise
total = plus + minus;
t = 0.5 * (total + zinverse((1 - confidencelevel) / 2) * sqrt(total))
if plus >= t && plus <= total - t,
  accepted = 1;
else
  accepted = 0;
end