function [result] = oa_precisionrecall(confusion)
  result(:, 1) = oa_precision(confusion);
  result(:, 2) = oa_recall(confusion);
end