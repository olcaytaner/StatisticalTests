function [G, H, a, N, n, p] = oa_nonparametric_matrices(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: [G, H, a, N, n, p] = oa_nonparametric_matrices('10fold', 'acceptors', 1, ['c45'; 'knn'; 'lda'], 'roc');
%Example run: [G, H, a, N, n, p] = oa_nonparametric_matrices('10fold', 'breast', 1, ['c45'; 'lda'], 'roc');
  [a tmp] = size(algorithms);
  ranks = oa_separateranks(subfolder, dataset, runindex, algorithms, metrictype);
	[n, p] = size(ranks{1, 1});
  N = n * a;
	for i = 1 : a
		ridot(i,:) = sum(ranks{1, i}) / n;
	end
	rdotdot = sum(ridot) / a;
	H = 0;
	for i = 1 : a
		H = H + (ridot(i, :) - rdotdot).'*(ridot(i, :) - rdotdot);
	end
	H = n * H / (a - 1);
	G = 0;
	for i = 1 : a
		for j = 1 : n
			x = ranks{1, i};
			G = G + (x(j, :) - ridot(i, :)).'*(x(j, :) - ridot(i, :));
		end
	end
  G = G / (N - a);
end
