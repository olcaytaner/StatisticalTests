function [result] = oa_accuracy(confusion)
  result = 1 - oa_error(confusion);
end