function oa_histogram(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: oa_histogram('10fold', 'breast', 1, ['lda'; 'qda'], 'error');
%Example run: oa_histogram('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'error');
  hold off;
  [L tmp] = size(algorithms);
  for i = 1 : L
    performance(:, i) = 100 * oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithms(i, :)), metrictype);
  end 
  hist(performance);
  hold on;
  xlabel('Error', 'FontSize', 14);
  leg = legend(algorithms);
  set(leg, 'FontSize', 14);
  set(gca, 'FontSize', 14);
end