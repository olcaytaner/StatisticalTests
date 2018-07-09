function [datasets, algorithms] = oa_datasets_algorithms(subfolder)
  switch subfolder
    case '10fold'
      datasets = ['acceptors';'ads';'artificial';'australian';'breast';'bupa';'credit';'cylinder';'dlbcl';'donors';'german';'haberman';'heart';'hepatitis';'horse';'ironosphere';'krvskp';'magic';'mammographic';'monks';'mushroom';'musk2';'parkinsons';'pima';'polyadenylation';'promoters';'prostatetumor';'ringnorm';'satellite47';'spambase';'spect';'tictactoe';'titanic';'transfusion';'twonorm';'vote'];
      algorithms = ['c45';'knn';'lda';'qda';'svm'];
    case '30fold'
      datasets = ['artificial';'australian';'breast';'bupa';'credit';'cylinder';'german';'haberman';'heart';'hepatitis';'horse';'ironosphere';'parkinsons';'pima';'satellite47';'spect';'tictactoe';'titanic';'transfusion';'vote'];
      algorithms = ['c45';'knn';'lda';'qda';'svm'];
    case 'bioinformatics'
      datasets = ['acceptors';'ads';'donors';'polyadenylation'];
      algorithms = ['c45';'knn';'lda';'qda';'randomforest';'svm1';'svm2'];
  end
end