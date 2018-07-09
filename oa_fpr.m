function [result] = oa_fpr(confusion)
%Columns must be in the order of TP, FP, TN, FN
  fp = confusion(:, 2);
  tn = confusion(:, 3);
  n = fp + tn;
  result(:, 1) = fp ./ n;
end