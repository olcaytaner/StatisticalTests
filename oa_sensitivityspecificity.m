function [result] = oa_sensitivityspecificity(confusion)
  roc = oa_tprfpr(confusion);
  tpr = roc(:, 1);
  fpr = roc(:, 2);
  result(:, 1) = tpr;
  result(:, 2) = 1 - fpr;
end