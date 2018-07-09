function  [reject, pvalue] = kfoldt(performance)
%Example run:
%[reject pvalue] = kfoldt([1 13; 2 12; 3 11; 4 12; 5 13]); 
	if nargin < 1
		disp('Enter a performance matrix');
		reject = false;
		pvalue = 0.5;
		return;
	end
	[k, L] = size(performance);
	if L != 2
		disp('Performance matrix must contain two columns');
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
	d = performance(:,1) - performance(:,2);
	daverage = sum(d) / k;
	dvariance = sum((d - daverage).*(d - daverage)) / (k - 1);
	if (dvariance == 0.0)
		disp('Variance is zero. Failed to reject the null hypothesis');
		reject = false;
		pvalue = 0.5;
		return;
	end
	teststatistic = sqrt(k) * daverage / sqrt(dvariance);
	dof = k - 1;
	pvalue = 1 - tcdf(abs(teststatistic), dof);
	if pvalue < 0.025 
		reject = true;
        else
		reject = false;
        end
end

