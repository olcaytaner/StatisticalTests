function  [reject, pvalue] = oa_kfoldt(subfolder, dataset, runindex, algorithm1, algorithm2, metrictype)
%Example run: [reject pvalue] = kfoldt("10fold", "acceptors", 1, "c45", "lda", "error");
  performance(:, 1) = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithm1), metrictype);
  performance(:, 2) = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithm2), metrictype);
  [k, L] = size(performance);
	d = performance(:, 1) - performance(:, 2);
	daverage = sum(d) / k;
	dvariance = sum((d - daverage).*(d - daverage)) / (k - 1);
	if dvariance == 0.0
		disp('Variance is zero. Failed to reject the null hypothesis');
		reject = false;
		pvalue = 0.5;
		return;
	end
	teststatistic = sqrt(k) * daverage / sqrt(dvariance);
	dof = k - 1;
	pvalue = 1 - tcdf(abs(teststatistic), dof);
	if pvalue < 0.025 
		reject = true;
  else
		reject = false;
  end
end