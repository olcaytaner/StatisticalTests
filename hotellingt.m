function  [reject, pvalue] = hotellingt(performance1, performance2)
%Example run:
%[reject pvalue] = hotellingt([1 2; 3 4; 6 5; 10 7], [3 5; 6 2; 5 7; 8 6]); 
	if nargin != 2
		disp('Enter two performance matrices');
		reject = false;
		pvalue = 0.5;
		return;
	end
	[row1, column1] = size(performance1);
	[row2, column2] = size(performance2);
	if column1 != column2
		disp('Performance matrices must have the same number of columns');
		reject = false;
		pvalue = 0.5;
		return;
	end
	if row1 != row2
		disp('Performance matrices must have the same number of rows');
		reject = false;
		pvalue = 0.5;
		return;
	end
	p = column1;
	k = row1;
	if k < 2
		disp('Enter at least two performance values');
		reject = false;
		pvalue = 0.5;
		return;
	end
	d = performance1 - performance2
	daverage = sum(d) / k;
	dcovariance = 0;
	for j=1:k,
		dcovariance += (d(j,:) - daverage).'*(d(j,:) - daverage) / (k - 1);
	end
	if det(dcovariance) == 0.0
		disp('Covariance matrix determinant zero. Failed to reject the null hypothesis.');
		reject = false;
		pvalue = 0.5;
		return;
	end
	teststatistic = k*daverage*inv(dcovariance)*daverage.';
	m = k - 1;
	fteststatistic = ((m - p + 1) / (m * p)) * teststatistic;
	pvalue = 1 - fcdf(fteststatistic, p, m - p + 1);
	if pvalue < 0.05 
		reject = true;
        else
		reject = false;
        end
end

