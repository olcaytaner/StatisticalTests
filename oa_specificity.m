function [result] = oa_specificity(confusion)
  result = 1 - oa_fpr(confusion);
end