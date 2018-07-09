function [result, sig_diffs, avg_ranks, CD, ranks] = friedman_test(data, alpha)
%FRIEDMAN_TEST returns the result, significant differences, average ranks, critical difference and ranks for each data set using Friedman's test
%   result is 0 if there is no significant difference between the algorithms, 1 o/w
%   sig_diffs is a matrix of 0s and 1s of size (num_algorithms, num_algorithms) and an entry (i, j) is 1 if the accuracies of algorithm i and algorithm j are significantly different from each other.
%   avg_ranks is the average ranks of the algorithms
%   CD is the critical distance to separate algorithms. Makes sense for Nemenyi's test
%   ranks is the ranks of all data sets
%   data should be of size (num_algorithms, num_datasets, num_folds) and contain errors
%   alpha should be given as 0.01, 0.001, 0.05 (not 0.99 etc)
CD = 1;	 	
num_algorithms = size(data, 1);
if num_algorithms > 50
	display('algorithm count should be less than or equal to 50!!!');
	return;
end
num_datasets = size(data, 2);
num_folds = size(data, 3);
for i = 1:num_algorithms
	performance(:, i) = mean(reshape(data(i, :, :), num_datasets, num_folds), 2);
end
for i = 1:num_datasets
	ranks(i, :) = tiedrank(performance(i,:));
end
avg_ranks = mean(ranks, 1);
chi_statistics = (12 * num_datasets) * (sum(avg_ranks.^2) - 0.25 * num_algorithms * (num_algorithms + 1)^2)/ (num_algorithms * (num_algorithms + 1));
chi_critical = chi2inv(1 - alpha, num_algorithms - 1);
	
sig_diffs = zeros(num_algorithms, num_algorithms);
if abs(chi_statistics) > chi_critical
	result = 1;
	q_alpha = [0.000 2.576 2.913 3.113 3.255 3.364 3.452 3.526 3.590 3.646 3.696 3.741 3.781 3.818 3.853 3.884 3.914 3.941 3.967 3.992 4.015 4.037 4.057 4.077 4.096 4.114 4.132 4.148 4.164 4.179 4.194 4.208 4.222 4.236 4.249 4.261 4.273 4.285 4.296 4.307 4.318 4.329 4.339 4.349 4.359 4.368 4.378 4.387 4.395 4.404;0.000 1.960 2.344 2.569 2.728 2.850 2.948 3.031 3.102 3.164 3.219 3.268 3.313 3.354 3.391 3.426 3.458 3.489 3.517 3.544 3.569 3.593 3.616 3.637 3.658 3.678 3.696 3.714 3.732 3.749 3.765 3.780 3.795 3.810 3.824 3.837 3.850 3.863 3.876 3.888 3.899 3.911 3.922 3.933 3.943 3.954 3.964 3.973 3.983 3.992;0.000 1.645 2.052 2.291 2.460 2.589 2.693 2.780 2.855 2.920 2.978 3.030 3.077 3.120 3.159 3.196 3.230 3.261 3.291 3.319 3.346 3.371 3.394 3.417 3.439 3.459 3.479 3.498 3.516 3.533 3.550 3.567 3.582 3.597 3.612 3.626 3.640 3.653 3.666 3.679 3.691 3.703 3.714 3.726 3.737 3.747 3.758 3.768 3.778 3.788];
    if alpha == 0.01
	   alpha_index = 1;
    elseif alpha == 0.05
	   alpha_index = 2;
    elseif alpha == 0.10
	   alpha_index = 3;
    else
	   display('alpha should be one of [0.01, 0.05, 0.10]!!!');
	return;
    end
    SE = sqrt(num_algorithms * (num_algorithms + 1) / (6 * num_datasets));
    CD = q_alpha(alpha_index, num_algorithms) * SE;
    for first_algorithm = 1:num_algorithms - 1
	   for second_algorithm = first_algorithm + 1:num_algorithms
		  if abs(avg_ranks(first_algorithm) - avg_ranks(second_algorithm)) > CD
	     	  	sig_diffs(first_algorithm, second_algorithm) = 1;
	  	     	sig_diffs(second_algorithm, first_algorithm) = 1;
		  end
	   end
    end
else
	result = 0;
end
