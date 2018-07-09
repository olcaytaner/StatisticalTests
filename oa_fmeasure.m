function [result] = oa_fmeasure(confusion)
  pr = oa_precisionrecall(confusion);
  precision = pr(:, 1);
  recall = pr(:, 2);
  result = 2 .* (precision .* recall) ./ (precision + recall);
end