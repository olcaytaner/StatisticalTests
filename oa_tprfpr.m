function [result] = oa_tprfpr(confusion)
  result(:, 1) = oa_tpr(confusion);
  result(:, 2) = oa_fpr(confusion);
end