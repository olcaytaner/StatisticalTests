function  [reject, pvalue] = oa_anova(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: [reject pvalue] = anova("10fold", "acceptors", 1, ["c45"; "knn"; "lda"], "error");
  [L tmp] = size(algorithms);
  for i = 1 : L
    performance(:, i) = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithms(i, :)), metrictype);
  end 
	[k, L] = size(performance);
	eidot = sum(performance) / k;
	edotdot = sum(eidot) / L;
	ssbetween = 0;
	for i = 1 : L
		ssbetween = ssbetween + (eidot(i) - edotdot) * (eidot(i) - edotdot);
	end
	ssbetween = ssbetween*k;
	msbetween = ssbetween / (L - 1);
	sswithin = 0;
	for i = 1 : k
		for j = 1 : L
			sswithin = sswithin + performance(i, j) - eidot(j);
		end
	end
	mswithin = sswithin / (L * (k - 1));
	teststatistic = msbetween / mswithin;
	pvalue = 1 - fcdf(teststatistic, L - 1, L * (k - 1));
	if pvalue < 0.05 
		reject = true;
  else
		reject = false;
  end
end