function oa_histogram_parametric_reduced(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: oa_histogram_parametric_reduced('10fold', 'spect', 4, ['lda'; 'qda'; 'svm'], 'roc');
%Example run: oa_histogram_parametric_reduced('10fold', 'australian', 3, ['c45'; 'knn'; 'lda'; 'qda'], 'confusion');
  [E, H, L, k, p] = oa_parametric_matrices(subfolder, dataset, runindex, algorithms, metrictype);
  [eigenvectors, eigenvalues] = eigs(inv(E) * H);
  reduced = eigenvectors(:, 1);
  eigenvalues(1, 1) / sum(sum(eigenvalues));
  for i = 1 : L
    performance(:, i) = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithms(i, :)), metrictype) * reduced;
  end 
  hold off;
  hist(performance);
  hold on;
  leg = legend(algorithms);
  set(leg, 'FontSize', 14);
  set(gca, 'FontSize', 14);
end