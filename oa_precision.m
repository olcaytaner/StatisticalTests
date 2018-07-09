function [result] = oa_precision(confusion)
%Columns must be in the order of TP, FP, TN, FN
  tp = confusion(:, 1);
  fp = confusion(:, 2);
  pprime = tp + fp;
  for i = 1 : size(pprime)
    if pprime(i, 1) > 0
      result(i, 1) = tp(i, 1) / pprime(i, 1);
    else
      result(i, 1) = 0;
    end
  end
end