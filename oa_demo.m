function oa_demo 
  printf('---------------------------------\nPairwise Cases:\n---------------------------------\n');
%Case 1: Parametric test reject.
   printf('Case 1:\n');
   [reject pvalue] = oa_hotellingt('bioinformatics', 'donors', 6, 'qda', 'svm2', 'roc')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'donors', 6, ['qda'; 'svm2'], 'roc', 'anova')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'donors', 6, ['qda'; 'svm2'], 'roc', 'lawley')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'donors', 6, ['qda'; 'svm2'], 'roc', 'bartlett')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'donors', 6, ['qda'; 'svm2'], 'roc', 'wilks')
%Case 2: Parametric test reject.
   printf('Case 2:\n');
   [reject pvalue] = oa_hotellingt('bioinformatics', 'ads', 10, 'svm1', 'randomforest', 'pr')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'ads', 10, ['svm1'; 'randomforest'], 'pr', 'anova')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'ads', 10, ['svm1'; 'randomforest'], 'pr', 'lawley')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'ads', 10, ['svm1'; 'randomforest'], 'pr', 'bartlett')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'ads', 10, ['svm1'; 'randomforest'], 'pr', 'wilks')
%Case 3: Parametric test reject.
   printf('Case 3:\n');
   [reject pvalue] = oa_hotellingt('10fold', 'breast', 1, 'lda', 'qda', 'roc')
   [reject pvalue] = oa_nonparametric('10fold', 'breast', 1, ['lda'; 'qda'], 'roc', 'anova')
   [reject pvalue] = oa_nonparametric('10fold', 'breast', 1, ['lda'; 'qda'], 'roc', 'lawley')
   [reject pvalue] = oa_nonparametric('10fold', 'breast', 1, ['lda'; 'qda'], 'roc', 'bartlett')
   [reject pvalue] = oa_nonparametric('10fold', 'breast', 1, ['lda'; 'qda'], 'roc', 'wilks')
%Case 4: Parametric test reject.
   printf('Case 4:\n');
   [reject pvalue] = oa_hotellingt('10fold', 'pima', 1, 'c45', 'qda', 'roc')
   [reject pvalue] = oa_nonparametric('10fold', 'pima', 1, ['c45'; 'qda'], 'roc', 'anova')
   [reject pvalue] = oa_nonparametric('10fold', 'pima', 1, ['c45'; 'qda'], 'roc', 'lawley')
   [reject pvalue] = oa_nonparametric('10fold', 'pima', 1, ['c45'; 'qda'], 'roc', 'bartlett')
   [reject pvalue] = oa_nonparametric('10fold', 'pima', 1, ['c45'; 'qda'], 'roc', 'wilks')
%Case 5: Parametric test failed to reject.
   printf('Case 5:\n');
   [reject pvalue] = oa_hotellingt('10fold', 'pima', 1, 'c45', 'qda', 'pr')
   [reject pvalue] = oa_nonparametric('10fold', 'pima', 1, ['c45'; 'qda'], 'pr', 'anova')
   [reject pvalue] = oa_nonparametric('10fold', 'pima', 1, ['c45'; 'qda'], 'pr', 'lawley')
   [reject pvalue] = oa_nonparametric('10fold', 'pima', 1, ['c45'; 'qda'], 'pr', 'bartlett')
   [reject pvalue] = oa_nonparametric('10fold', 'pima', 1, ['c45'; 'qda'], 'pr', 'wilks')
%Case 6: Parametric test failed to reject.
   printf('Case 6:\n');
   [reject pvalue] = oa_hotellingt('10fold', 'spect', 4, 'c45', 'svm', 'roc')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'svm'], 'roc', 'anova')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'svm'], 'roc', 'lawley')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'svm'], 'roc', 'bartlett')   
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'svm'], 'roc', 'wilks')   
   printf('---------------------------------\nMultiple Cases:\n---------------------------------\n');
%Case 1: Parametric test reject.
   printf('Case 1\n');
   [reject pvalue] = oa_manova('bioinformatics', 'polyadenylation', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'randomforest'], 'roc')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'polyadenylation', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'randomforest'], 'roc', 'anova')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'polyadenylation', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'randomforest'], 'roc', 'lawley')
   [reject pvalue] = oa_nonparametric('bioinformatics', 'polyadenylation', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'randomforest'], 'roc', 'bartlett')  
   [reject pvalue] = oa_nonparametric('bioinformatics', 'polyadenylation', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'randomforest'], 'roc', 'wilks')  
%Case 2: Parametric test reject.
   printf('Case 2\n');
   [reject pvalue] = oa_manova('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc', 'anova')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc', 'lawley')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc', 'bartlett') 
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc', 'wilks') 
%Case 3: Parametric test reject.
   printf('Case 3\n');
   [reject pvalue] = oa_manova('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'pr')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'pr', 'anova')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'pr', 'lawley')
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'pr', 'bartlett')      
   [reject pvalue] = oa_nonparametric('10fold', 'spect', 4, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'pr', 'wilks')      
%Case 4: Parametric test reject.
   printf('Case 4\n');
   [reject pvalue] = oa_manova('10fold', 'breast', 2, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc')
   [reject pvalue] = oa_nonparametric('10fold', 'breast', 2, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc', 'anova')
   [reject pvalue] = oa_nonparametric('10fold', 'breast', 2, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc', 'lawley')
   [reject pvalue] = oa_nonparametric('10fold', 'breast', 2, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc', 'bartlett') 
   [reject pvalue] = oa_nonparametric('10fold', 'breast', 2, ['c45'; 'knn'; 'lda'; 'qda'; 'svm'], 'roc', 'wilks')         
end