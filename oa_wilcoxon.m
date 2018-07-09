function [reject, pvalue] = oa_wilcoxon(subfolder, dataset, runindex, algorithm1, algorithm2, metrictype)
%Example run: [reject pvalue] = wilcoxon("10fold", "acceptors", 1, "c45", "lda", "error");
  performance(:, 1) = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithm1), metrictype);
  performance(:, 2) = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithm2), metrictype);
  [k, L] = size(performance);
  performance_difference = abs(performance(:, 1) - performance(:, 2))';
  ranks = oa_tiedrank(performance_difference);
  signed_sum = 0;
  for i = 1 : k
	  if performance(i, 1) - performance(i, 2) > 0
		  signed_sum = signed_sum + ranks(i);
	  else
	  	signed_sum = signed_sum - ranks(i);
	  end
  end
  signed_sum = abs(signed_sum);
  wilcoxon_statistics = (signed_sum - 0.5) / sqrt(k * (k + 1) * (2 * k + 1) / 6);
  pvalue = 1 - normcdf(wilcoxon_statistics, 0, 1);
  if pvalue < 0.025
	  reject = true;
  else
	  reject = false;
  end
end