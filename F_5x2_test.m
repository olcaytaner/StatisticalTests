function [result, p_val] = F_5x2_test(first_errors, second_errors, alpha)
%5X2F_TEST checks if the first vector is significantly different than the second one using 5x2 F test and alpha
%   result = 0 or 1 meaning not significantly different or better respectively
%   p_val is the p value of the comparison
%   first_errors is a row vector of errors of the first algorithm
%   second_errors is a row vector of errors of the second algorithm
%   alpha should be given as 0.01, 0.001, 0.05 (not 0.99 etc)
alpha = 1 - alpha;
result = 1;

temp = (first_errors - second_errors)';


num_folds = 5;
p = zeros(num_folds, 2);
pbar = zeros(num_folds, 2);
s_square = zeros(num_folds, 1);
m = 0;

for fold = 1:num_folds
	p(fold, 1) = temp(2 * fold - 1, 1);
	p(fold, 2) = temp(2 * fold, 1);
	pbar(fold, 1) = (p(fold, 1) + p(fold, 2)) / 2;
	s_square(fold, 1) = (p(fold, 1) - pbar(fold, 1))^2 + (p(fold, 2) - pbar(fold, 1))^2;
end

m = sum(s_square);
n = sum(sum(p.^2));

f_critical = finv(alpha,10,5);



if (m ~= 0)
	f = n / (2 * m);
	p_val = fcdf(f, 10, 5);
	if (f < f_critical)
		result = 0;
	else
		result = 1;
	end
else
	result = 0;
end
p_val = 1 - p_val;
