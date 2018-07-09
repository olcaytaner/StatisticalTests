function  [reject, pvalue] = anova(performance)
%Example run:
%[reject pvalue] = anova([1 13 2; 2 12 4; 3 11 6; 4 12 8; 5 13 17]); 
	if nargin < 1
		disp('Enter a performance matrix');
		reject = false;
		pvalue = 0.5;
		return;
	end
	[k, L] = size(performance);
	if L < 2
		disp('Enter at least two algorithms performance values');
		reject = false;
		pvalue = 0.5;
		return;
	end
	if k < 2
		disp('Enter at least two performance values');
		reject = false;
		pvalue = 0.5;
		return;
	end
	eidot = sum(performance) / k;
	edotdot = sum(eidot) / L;
	ssbetween = 0;
	for i=1:L,
		ssbetween += (eidot(i) - edotdot)*(eidot(i) - edotdot);
	end
	ssbetween *= k;
	msbetween = ssbetween / (L - 1);
	sswithin = 0;
	for i=1:k,
		for j=1:L,
			sswithin += performance(i, j) - eidot(j);
		end
	end
	mswithin = sswithin / (L * (k - 1));
	teststatistic = msbetween / mswithin;
	pvalue = 1 - fcdf(teststatistic, L - 1, L * (k - 1));
	if pvalue < 0.05 
		reject = true;
        else
		reject = false;
        end
end

