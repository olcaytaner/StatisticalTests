function oa_plotranks(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: oa_plotranks('10fold', 'breast', 1, ['lda'; 'qda'], 'roc');
%Example run: oa_plotranks('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc');
%Example run: oa_plotranks('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'pr');
%Example run: oa_plotranks('10fold', 'bupa', 4, ['c45'; 'lda'], 'roc');
  hold off;
  [L tmp] = size(algorithms);
  [ranks] = oa_separateranks(subfolder, dataset, runindex, algorithms, metrictype);
  for i = 1 : L
    performance = ranks{1, i};
    switch i
      case 1
        plot(performance(:, 1), performance(:, 2), 'k+');
        hold on;
        plot(mean(performance(:, 1)), mean(performance(:, 2)), 'kd', 'markersize', 16);
      case 2
        plot(performance(:, 1), performance(:, 2), 'ro');
        plot(mean(performance(:, 1)), mean(performance(:, 2)), 'rd', 'markersize', 16);
      case 3
        plot(performance(:, 1), performance(:, 2), 'g*');
        plot(mean(performance(:, 1)), mean(performance(:, 2)), 'gd', 'markersize', 16);
      case 4
        plot(performance(:, 1), performance(:, 2), 'bx');
        plot(mean(performance(:, 1)), mean(performance(:, 2)), 'bd', 'markersize', 16);
      case 5
        plot(performance(:, 1), performance(:, 2), 'ms');
        plot(mean(performance(:, 1)), mean(performance(:, 2)), 'md', 'markersize', 16);
    end
  end 
  switch metrictype
    case 'roc'
      xlabel('Tpr', 'FontSize', 14);
      ylabel('Fpr', 'FontSize', 14);
    case 'pr'
      xlabel('Precision', 'FontSize', 14);
      ylabel('Recall', 'FontSize', 14);
  end
  hold off;
end