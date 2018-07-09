function  [reject, pvalue] = oa_manova(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: [reject pvalue] = oa_manova("10fold", "acceptors", 1, ["c45"; "knn"; "lda"], "roc");
  [E, H, L, k, p] = oa_parametric_matrices(subfolder, dataset, runindex, algorithms, metrictype);
	if det(E + H) == 0.0
		disp('The determinant of E + H is zero. Failing to reject the null hypothesis.');
		reject = false;
		pvalue = 0.5;
		return;
	end
	teststatistic = det(E) / (det(E + H));
	m = L * (k - 1);
	n = L - 1;
	chiteststatistic = ((p - n + 1) / 2 - m) * log(teststatistic);
	pvalue = 1 - chi2cdf(chiteststatistic, n * p);
	if pvalue < 0.05 
		reject = true;
  else
		reject = false;
  end
end