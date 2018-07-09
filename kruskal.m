function accepted = kruskal(treatments, confidencelevel)
% accepted = kruskal(treatments, confidencelevel)
% each treatment is stored in one column.
% Makes kruskal-wallis test. H0: m1=m2=...=mk
% If H0 accepted, function returns 1, 0 otherwise
[rows, columns] = size(treatments);
k=0;
for i=1:rows,
  for j=1:columns,
    k=k+1;
    xindex(k)=i;
    yindex(k)=j;
    t(k)=treatments(i,j);
  end
end
for i=1:k-1,
  j=i+1;
  while t(j)<t(j-1),
    tmp=t(j);
    t(j)=t(j-1);
    t(j-1)=tmp;
    tmp=xindex(j);
    xindex(j)=xindex(j-1);
    xindex(j-1)=tmp;
    tmp=yindex(j);
    yindex(j)=yindex(j-1);
    yindex(j-1)=tmp;    
    j=j-1;
    if j==1,
      break;
    end
  end
end
i=1;
while i<=k,
  j=i;
  if i+1<=k,
    while t(i)==t(i+1),
      i=i+1;
      if i+1>k,
        break;
      end
    end  
  end  
  if i~=j,
    sum=0;
    for l=j:i,
      sum=sum+l;
    end  
    for l=j:i,
      rij(l)=sum/(i-j+1);
    end  
  else
    rij(i)=i;
  end   
  i=i+1;
end
for i=1:columns,
  tsums(i)=0;
end
for i=1:k,
  tsums(yindex(i)) = tsums(yindex(i)) + rij(i);
end
tsquares=tsums.^2;  
total=0;
for i=1:columns,
  total=total+tsquares(i);
end
total=total/rows;
statistic = total*(12/(k*(k+1)))-3*(k+1);
threshold = chiinv(confidencelevel, columns-1);
if statistic < threshold,
  accepted = 1;
else
  accepted = 0;
end    