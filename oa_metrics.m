function [result] = oa_metrics(confusion, metrictype)
%Example #1: metrics(a, "roc") for tpr-fpr metrics
%Example #2: metrics(a, "pr") for precision-recall metrics
%Example #3: metrics(a, "ss") for sensitivity-specificity metrics
  if nargin ~= 2
    disp('Enter confusion matrix and metric type');
    return;
  end
  switch metrictype
    case 'tpr'
      result = oa_tpr(confusion);
    case 'fpr'
      result = oa_fpr(confusion);
    case 'precision'
      result = oa_precision(confusion);
    case 'recall'
      result = oa_recall(confusion);
    case 'sensitivity'
      result = oa_sensitivity(confusion);
    case 'specificity'
      result = oa_specificity(confusion);
    case 'roc'
      result = oa_tprfpr(confusion);
    case 'pr'
      result = oa_precisionrecall(confusion);
    case 'ss'
      result = oa_sensitivityspecificity(confusion);
    case 'accuracy'
      result = oa_accuracy(confusion);
    case 'error'
      result = oa_error(confusion);
    case 'f'
      result = oa_fmeasure(confusion);
    otherwise
      result = confusion;
  end
end