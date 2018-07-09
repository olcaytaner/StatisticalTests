function  [reject, pvalue] = oa_hotellingt(subfolder, dataset, runindex, algorithm1, algorithm2, metrictype)
%Example run: [reject pvalue] = oa_hotellingt("10fold", "acceptors", 1, "c45", "knn", "roc");
%Example run: [reject pvalue] = oa_hotellingt("10fold", "breast", 1, "c45", "lda", "roc");
  performance1 = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithm1), metrictype);
  performance2 = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithm2), metrictype);
	[row1, column1] = size(performance1);
	[row2, column2] = size(performance2);
	p = column1;
	k = row1;
	d = performance1 - performance2;
	daverage = sum(d) / k;
	dcovariance = 0;
	for j = 1 : k
		dcovariance = dcovariance + (d(j, :) - daverage).'*(d(j, :) - daverage) / (k - 1);
	end
	while det(dcovariance) == 0.0
    [eigenvectors, eigenvalues] = eigs(dcovariance);
    reduced = eigenvectors(:, 1 : p - 1);
    dcovariance = reduced' * dcovariance * reduced;
    daverage = daverage * eigenvectors(:, 1 : p - 1);
    p = p - 1;
    if p == 1
      break;
    end
	end
	teststatistic = k * daverage * inv(dcovariance) * daverage.';
	m = k - 1;
	fteststatistic = ((m - p + 1) / (m * p)) * teststatistic;
	pvalue = 1 - fcdf(fteststatistic, p, m - p + 1);
	if pvalue < 0.05 
		reject = true;
  else
		reject = false;
  end
end