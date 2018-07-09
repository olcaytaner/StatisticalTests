function [reject, pvalue] = oa_f_5x2(subfolder, dataset, runindex, algorithm1, algorithm2, metrictype)
%Example run: [reject pvalue] = f_5x2("10fold", "acceptors", 1, "c45", "lda", "error");
  performance(:, 1) = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithm1), metrictype);
  performance(:, 2) = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithm2), metrictype);
  temp = (performance(:, 1) - performance(:, 2));
  num_folds = 5;
  p = zeros(num_folds, 2);
  pbar = zeros(num_folds, 2);
  s_square = zeros(num_folds, 1);
  m = 0;
  for fold = 1 : num_folds
  	p(fold, 1) = temp(2 * fold - 1, 1);
  	p(fold, 2) = temp(2 * fold, 1);
  	pbar(fold, 1) = (p(fold, 1) + p(fold, 2)) / 2;
  	s_square(fold, 1) = (p(fold, 1) - pbar(fold, 1))^2 + (p(fold, 2) - pbar(fold, 1))^2;
  end
  m = sum(s_square);
  n = sum(sum(p.^2));
  if m ~= 0
  	f = n / (2 * m);
  	pvalue = 1 - fcdf(f, 10, 5);
  	if pvalue < 0.05
  		reject = true;
  	else
  		reject = false;
  	end
  else
  	reject = false;
  end
end
