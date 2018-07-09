function accepted = mcnemar(results, confidencelevel)
% accepted = mcnemar(results, confidencelevel)
% Makes mcnemar's test. H0: m1 = m2
% result is a 2 x 2 array.
% If H0 accepted, function returns 1, 0 otherwise
b = results(1, 2);
c = results(2, 1);
t = (b - c).^2 / (b + c);
if t <= chiinv(1 - confidencelevel, 1),
  accepted = 1;
else
  accepted = 0;
end