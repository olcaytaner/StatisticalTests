function equalities = duncan(treatments, confidencelevel)
% equalities = duncan(treatments, confidencelevel)
% each treatment is stored in one column.
% Makes duncan test. H0: m1=m2=...=mk
% Returns an array of equal classifier indexes
% equalities(1, 1) = 1, equalities(1, 2) = 3 means that classifiers 1,2,3 are equal to each other
% equalities(1, 1) = 4, equalities(1, 2) = 5 means that classifiers 4,5 are equal to each other
[rows, columns] = size(treatments);
meansquareerror = mse(treatments);
multiplier = sqrt(meansquareerror / rows);
count = 0;
for i = columns - 1: -1: 1,
    for j = 1: columns - i,
        found = 0;
        for k = 1: count,
            if j >= equalities(k, 1) && j + i <= equalities(k, 2),
                found = 1;
            end
        end
        if found == 0,
            for k = j: j + i,
                treatments2(:, k - j + 1) = treatments(:, k);
            end
            meanvector = mean(treatments2);      
            level = 1 - ((1 - confidencelevel).^i)
            criticalpoint = qdistinv(level, columns * (rows - 1), i + 1);
            multiplied = multiplier * criticalpoint;
            if meanvector(i + 1) - meanvector(1) <= multiplied,
                count = count + 1;
                equalities(count, 1) = j;
                equalities(count, 2) = j + i;
            end
        end
    end
end
end  