function [result, p_val] = wilcoxon_test(data, alpha)
%WILCOXON_TEST returns the result and p-value using Wilcoxon's signed rank test
%   result is 0 if there is no significant difference between the algorithms, 1 o/w
%   data should be of size (2, num_datasets, num_folds) and contain errors
%   alpha should be given as 0.01, 0.001, 0.05 (not 0.99 etc)
num_algorithms = 2;
num_datasets = size(data, 2);
num_folds = size(data, 3);
for i = 1:num_algorithms
	performance(:, i) = mean(reshape(data(i, :, :), num_datasets, num_folds), 2);
end
performance_difference = abs(performance(:, 1) - performance(:, 2));
ranks = tiedrank(performance_difference);
signed_sum = 0;
for i = 1:num_datasets
	if (performance(:, 1) - performance(:, 2) > 0)
		signed_sum += ranks(i);
	else
		signed_sum -= ranks(i);
	end
end
signed_sum = abs(signed_sum);
critical = norminv(1 - alpha, 0, 1);
wilcoxon_statistics = (signed_sum - 0.5) / sqrt(num_datasets * (num_datasets + 1) * (2 * num_datasets + 1) / 6);
p_val = 1 - normcdf(wilcoxon_statistics, 0, 1);
if wilcoxon_statistics > critical
	result = 1;
else
	result = 0;
end
