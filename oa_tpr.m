function [result] = oa_tpr(confusion)
%Columns must be in the order of TP, FP, TN, FN
  tp = confusion(:, 1);
  fn = confusion(:, 4);
  p = tp + fn;
  result(:, 1) = tp ./ p;
end