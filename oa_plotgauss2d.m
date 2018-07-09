function oa_plotgauss2d(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: oa_plotgauss2d('10fold', 'breast', 1, ['lda'; 'qda'], 'roc');
%Example run: oa_plotgauss2d('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc');
%Example run: oa_plotgauss2d('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'pr');
%Example run: oa_plotgauss2d('10fold', 'bupa', 4, ['c45'; 'lda'], 'roc');
  hold off;
  [L tmp] = size(algorithms);
  for i = 1 : L
    performance = oa_metrics(oa_confusion(subfolder, dataset, runindex, algorithms(i, :)), metrictype);
    switch i
      case 1
        plot(performance(:, 1), performance(:, 2), 'k+');
      case 2
        plot(performance(:, 1), performance(:, 2), 'ro');
      case 3
        plot(performance(:, 1), performance(:, 2), 'g*');
      case 4
        plot(performance(:, 1), performance(:, 2), 'bx');
      case 5
        plot(performance(:, 1), performance(:, 2), 'ms');
    end
    hold on;
    m = mean(performance);
    c = cov(performance);
    for sdwidth = [0.5:0.25:1.25],
      tt = linspace(0, 2 * pi, 100)';
      x = cos(tt); 
      y = sin(tt);
      ap = [x(:) y(:)]';
      [v, d] = eig(c); 
      d = sdwidth * sqrt(d);
      bp = v * d * ap;
      meanp = repmat(m', [1 100]);
      bp = bp + meanp;
      h = plot(bp(1, :), bp(2, :));
      switch i
        case 1
          set(h, 'color', 'k');          
        case 2
          set(h, 'color', 'r');          
        case 3
          set(h, 'color', 'g');          
        case 4
          set(h, 'color', 'b');          
        case 5
          set(h, 'color', 'm');          
      end
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
