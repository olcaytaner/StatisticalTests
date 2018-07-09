function [decision] = oa_multiple_experiment(subfolder, metrictype, statistictype)
%[decision] = oa_multiple_experiment('10fold', 'roc', 'anova')
%[decision] = oa_multiple_experiment('10fold', 'roc', 'lawley')
%[decision] = oa_multiple_experiment('10fold', 'roc', 'bartlett')
%[decision] = oa_multiple_experiment('10fold', 'roc', 'wilks')
%[decision] = oa_multiple_experiment('10fold', 'pr', 'anova')
%[decision] = oa_multiple_experiment('10fold', 'pr', 'lawley')
%[decision] = oa_multiple_experiment('10fold', 'pr', 'bartlett')
%[decision] = oa_multiple_experiment('10fold', 'pr', 'wilks')
  [datasets algorithms] = oa_datasets_algorithms(subfolder);
  decision = zeros(3, 3);
  dataset_count = size(datasets, 1);
  algorithm_count = size(algorithms, 1);
  for i = 1 : dataset_count
    dataset = strtrim(datasets(i, :));
    for j = 1 : 10
      candidate_algorithms = [];
      for k = 1 : algorithm_count
        algorithm = strtrim(algorithms(k, :));
        filename = sprintf('data/%s/%s-%d-%s.confusion', subfolder, dataset, j, algorithm);
        [status, result, msgid] = fileattrib(filename);
        if status > 0
          candidate_algorithms = vertcat(candidate_algorithms, algorithm);
        end
      end
      [reject1 pvalue1] = oa_manova(subfolder, dataset, j, candidate_algorithms, metrictype);
      [reject2 pvalue2] = oa_nonparametric(subfolder, dataset, j, candidate_algorithms, metrictype, statistictype);
      if pvalue1 < 0
        index1 = 3;
      else
        if reject1 > 0
          index1 = 2;
        else
          index1 = 1;
        end
      end
      if pvalue2 < 0
        index2 = 3;
      else
        if reject2 > 0
          index2 = 2;
        else
          index2 = 1;
        end
      end
      decision(index1, index2) = decision(index1, index2) + 1;
    end
  end
  decision = decision / sum(sum(decision));
end