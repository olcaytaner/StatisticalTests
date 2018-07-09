function oa_histogram_nonparametric_reduced(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: oa_histogram_nonparametric_reduced('10fold', 'spect', 4, ['lda'; 'qda'; 'svm'], 'roc');
%Example run: oa_histogram_nonparametric_reduced('10fold', 'australian', 3, ['c45'; 'knn'; 'lda'; 'qda'], 'confusion');
  [G, H, a, N, n, p] = oa_nonparametric_matrices(subfolder, dataset, runindex, algorithms, metrictype);
  [eigenvectors, eigenvalues] = eigs(inv(G) * H);
  reduced = eigenvectors(:, 1);
  eigenvalues(1, 1) / sum(sum(eigenvalues));
  ranks = oa_separateranks(subfolder, dataset, runindex, algorithms, metrictype);
  for i = 1 : a
    performance(:, i) = ranks{1, i} * reduced;
  end 
  hold off;
  hist(performance);
  hold on;
  leg = legend(algorithms);
  set(leg, 'FontSize', 14);
  set(gca, 'FontSize', 14);
end