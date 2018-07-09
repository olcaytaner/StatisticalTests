function prob=tdist(T,freedom)
%probability value = tdist(x, freedom)
%Returns the probability of t distribution with value of x and 
%with degree of freedom freedom.
if (T>=0)
  prob = (fdist(T*T,1,freedom)/2);
else
  prob = 1-(fdist(T*T,1,freedom)/2);
end