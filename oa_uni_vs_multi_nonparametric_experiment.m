function [decision] = oa_uni_vs_multi_nonparametric_experiment(subfolder, metrictype1, metrictype2, statistictype)
%[decision] = oa_uni_vs_multi_nonparametric_experiment('10fold', 'error', 'roc', 'anova')
%[decision] = oa_uni_vs_multi_nonparametric_experiment('10fold', 'f', 'pr', 'anova')
  [datasets algorithms] = oa_datasets_algorithms(subfolder);
  decision = zeros(3, 3);
  dataset_count = size(datasets, 1);
  algorithm_count = size(algorithms, 1);
  for i = 1 : dataset_count
    dataset = strtrim(datasets(i, :));
    for j = 1 : 10
      for k = 1 : algorithm_count - 1
        algorithm1 = strtrim(algorithms(k, :));
        filename1 = sprintf('data/%s/%s-%d-%s.confusion', subfolder, dataset, j, algorithm1);
        [status1, result, msgid] = fileattrib(filename1);
        if status1 > 0
          for l = k + 1 : algorithm_count
            algorithm2 = strtrim(algorithms(l, :));
            candidate_algorithms = [algorithm1 ; algorithm2];
            filename2 = sprintf('data/%s/%s-%d-%s.confusion', subfolder, dataset, j, algorithm2);
            [status2, result, msgid] = fileattrib(filename2);
            if status2 > 0
              [reject1 pvalue1] = oa_kfoldt(subfolder, dataset, j, algorithm1, algorithm2, metrictype1);
              [reject2 pvalue2] = oa_nonparametric(subfolder, dataset, j, candidate_algorithms, metrictype2, statistictype);
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
        end
      end
    end
  end
  decision = decision / sum(sum(decision));
end