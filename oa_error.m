function [result] = oa_error(confusion)
%Columns must be in the order of TP, FP, TN, FN
  if nargin ~= 1
    disp('Enter confusion matrix');
    return;
  end
  [row, column] = size(confusion);
  if column ~= 4
    disp('Confusion matrix must have 4 columns');
    return;
  end
  tp = confusion(:, 1);
  fp = confusion(:, 2);
  tn = confusion(:, 3);
  fn = confusion(:, 4);
  p = tp + fn;
  n = fp + tn;
  N = p + n;
  result(:, 1) = (fp + fn) ./ N;
end