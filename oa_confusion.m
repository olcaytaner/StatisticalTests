function [result] = oa_confusion(subfolder, dataset, runindex, algorithm)
%Loads the confusion matrix
%Example: confusion("10fold", "acceptors", 1, "c45")
  if nargin ~= 4
    disp('Enter subfolder, dataset name, algorithm name and index of the run');
    return;
  end
  result = load(['data/', subfolder, '/', dataset, '-', int2str(runindex), '-', algorithm, '.confusion']); 
end