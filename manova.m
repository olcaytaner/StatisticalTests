function  [reject, pvalue] = manova(performance)
%Example run:
%[reject pvalue] = manova({[1 2; 3 4; 8 6], [3 4; 6 8; 9 10], [6 7; 10 23; 2 78]}); 
	if nargin < 1
		disp('Enter a performance cell array');
		reject = false;
		pvalue = 0.5;
		return;
	end
	[tmp, L] = size(performance);
	if tmp != 1
		disp('Cell array must be a row matrix (1 by L)');
		reject = false;
		pvalue = 0.5;
		return;
	end
	if L < 2
		disp('Enter at least two algorithms performance values');
		reject = false;
		pvalue = 0.5;
		return;
	end
	[k, p] = size(performance{1,1});
	if k < 2
		disp('Enter at least two performance values');
		reject = false;
		pvalue = 0.5;
		return;
	end
	for i=1:L,
		xidot(i,:) = sum(performance{1,i}) / k;
	end
	xdotdot = sum(xidot) / L;
	H = 0;
	for i=1:L,
		H += (xidot(i,:) - xdotdot).'*(xidot(i,:) - xdotdot);
	end
	H = k*H;
	E = 0;
	for i=1:L,
		for j=1:k,
			x = performance{1,i};
			E += (x(j,:) - xidot(i,:)).'*(x(j,:) - xidot(i,:));
		end
	end
	if det(E + H) == 0.0
		disp('The determinant of E + H is zero. Failing to reject the null hypothesis.');
		reject = false;
		pvalue = 0.5;
		return;
	end
	teststatistic = det(E) / (det(E + H));
	m = L * (k - 1);
	n = L - 1;
	chiteststatistic = ((p - n + 1) / 2 - m) * log(teststatistic);
	pvalue = 1 - chi2cdf(chiteststatistic, n * p);
	if pvalue < 0.05 
		reject = true;
    else
		reject = false;
    end
end

