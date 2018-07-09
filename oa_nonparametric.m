function  [reject, pvalue] = oa_nonparametric(subfolder, dataset, runindex, algorithms, metrictype, statistictype)
%Example run: [reject pvalue] = oa_nonparametric('10fold', 'acceptors', 1, ['c45'; 'knn'; 'lda'], 'roc', 'anova');
%Example run: [reject pvalue] = oa_nonparametric('10fold', 'breast', 1, ['c45'; 'lda'], 'roc', 'anova');
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'lda'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'qda'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'svm'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['lda'; 'qda'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['lda'; 'svm'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['lda'; 'knn'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['qda'; 'svm'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['qda'; 'knn'], 'recall', 'anova')
%[reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['svm'; 'knn'], 'recall', 'anova')
  [G, H, a, N, n, p] = oa_nonparametric_matrices(subfolder, dataset, runindex, algorithms, metrictype);
  switch statistictype
    case 'anova'
      statistic = trace(H) / trace(G);
      f1 = trace(G)^2/trace(G^2);
      f2 = (f1 * a * (n - 1)) / (a - 1);
    case 'lawley'
    	if det(G) == 0.0 
		    %disp('The determinant of G is zero. Warning!');
		    reject = false;
		    pvalue = -1;
        return
	    end
	    if det(H) == 0.0
	    	%disp('The determinant of H is zero. Warning!');
	    	reject = false;
	    	pvalue = -1;
        return
	    end
      U = trace((a - 1) * H * (((N - a) * G)^-1));
      B = ((N - p - 2) * (N - a - 1)) / ((N - a - p) * (N - a - p - n));
      f1 = p * (a - 1);
      f2 = 4 + (f1 + 2) / (B - 1);
      g = (p * (a - 1) * (f2 - 2)) / ((N - a - p - 1) * f2);
      statistic = U / g;
    case 'bartlett'
    	if det(G) == 0.0 
		    %disp('The determinant of G is zero. Warning!');
		    reject = false;
		    pvalue = -1;
        return
	    end
	    if det(H) == 0.0
	    	%disp('The determinant of H is zero. Warning!');
	    	reject = false;
	    	pvalue = -1;
        return
	    end
      V = trace((a - 1) * H * (((a - 1) * H + (N - a) * G)^-1));
      gamma = min(a - 1, p);
      f1 = ((p * (a - 1)) / (gamma * (N - 1))) * ((gamma * (N - a + gamma - p) * (N + 2) * (N - 1)) / ((N - a) * (N - p)) - 2);
      f2 = ((N - a + gamma - p) / N) * ((gamma * (N - a + gamma - p) * (N + 2) * (N - 1)) / ((N - a) * (N - p)) - 2);
      statistic = ((V / gamma) / f1) / ((1 - V / gamma) / f2);
    case 'wilks'
    	if det(G) == 0.0 
		    %disp('The determinant of G is zero. Warning!');
		    reject = false;
		    pvalue = -1;
        return
	    end
	    if det(H) == 0.0
	    	%disp('The determinant of H is zero. Warning!');
	    	reject = false;
	    	pvalue = -1;
        return
	    end
      lambda = det(((N - a) * G) / ((N - a) * G + (a - 1) * H));
      r = (N - a) - (p - (a - 1) + 1) / 2;
      if p * (a - 1) == 2
        t = 1;
      else
        t = sqrt((p^2 * (a - 1)^2 - 4) / (p^2 + (a - 1)^2 - 5));
      end
      f1 = p * (a - 1);
      f2 = r * t - (p * (a - 1) - 2) / 2;
      statistic = ((1 - lambda^(1 / t)) / (lambda^(1 / t))) * (f2 / f1);
    otherwise
  end
  pvalue = 1 - fcdf(statistic, f1, f2);
  if pvalue < 0.05
  	reject = true;
  else
  	reject = false;
  end
end
