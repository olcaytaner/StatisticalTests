function  [ranks] = oa_separateranks(subfolder, dataset, runindex, algorithms, metrictype)
%Example run: [ranks] = oa_separateranks("10fold", "acceptors", 1, ["c45"; "knn"; "lda"], "roc");
  [L tmp] = size(algorithms);
  for i = 1 : L
    performance{1, i} = oa_metrics(oa_confusion(subfolder, dataset, runindex, strtrim(algorithms(i, :))), metrictype);
  end
 	[k, p] = size(performance{1, 1});
  for j = 1 : p
    concat = performance{1, 1}(:, j)';
    for i = 2 : L
      concat = horzcat(concat, performance{1, i}(:, j)');
    end
    concatrank = oa_tiedrank(concat);
    reshapedconcatrank = reshape(concatrank, k, L);
    for i = 1 : L
      ranks{1, i}(:, j) = reshapedconcatrank(:, i);
    end
  end 
end
