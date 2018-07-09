function  [E, H, L, k, p] = oa_parametric_matrices(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: [E, H, L, k, p] = oa_parametric_matrices('10fold', 'acceptors', 1, ['c45'; 'knn'; 'lda'], 'roc');
  [L tmp] = size(algorithms);
  for i = 1 : L
    performance{1, i} = oa_metrics(oa_confusion(subfolder, dataset, runindex, strtrim(algorithms(i, :))), metrictype);
  end
	[k, p] = size(performance{1, 1});
	for i = 1 : L
		xidot(i,:) = sum(performance{1, i}) / k;
	end
	xdotdot = sum(xidot) / L;
	H = 0;
	for i = 1 : L
		H = H + (xidot(i, :) - xdotdot).'*(xidot(i, :) - xdotdot);
	end
	H = k * H;
	E = 0;
	for i = 1 : L
		for j = 1 : k
			x = performance{1, i};
			E = E + (x(j, :) - xidot(i, :)).'*(x(j, :) - xidot(i, :));
		end
	end
end