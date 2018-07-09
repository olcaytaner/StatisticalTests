function totalstandarderror = mst(treatments)
%totalstandarderror = mst(treatments)
%calculates total standard error of the treatments
[rows, columns] = size(treatments);
meanvector = mean(treatments);
generalmean = mean(meanvector);
difference = meanvector - generalmean;
sst = rows*sum(difference.^2);
totalstandarderror = sst/(columns-1);
end  