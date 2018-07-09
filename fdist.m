function prob = fdist(F,freedom1,freedom2)
%probability value = fdist(F, freedom1, freedom2)
%Returns the probability of f distribution with value of F and 
%with degree of freedoms freedom1 and freedom2.
%Returns 1 if F < 0.000001 or freedoms < 1
if (F < 0.000001 | freedom1 < 1 | freedom2 < 1)
  prob = 1.0;
  return
end
if (mod(freedom1,2)==1)
  a=1;
else
  a=2;
end
if (mod(freedom2,2)==1)
  b=1;
else
  b=2;
end
w = (F * freedom1) / freedom2;
z = 1.0 / (1.0 + w);
if (a == 1)
  if (b == 1)
     p = sqrt (w);
     y = 1 / 3.14159;
     d = y * z / p;
     p = 2.0 * y * atan (p);
  else
     p = sqrt (w * z);
     d = 0.5 * p * z / w;
  end
else
  if (b == 1)
    p = sqrt (z);
    d = 0.5 * z * p;
    p = 1.0 - p;
  else
    d = z * z;
    p = w * z;
  end
end
y = 2.0 * w / z;
for j = b + 2:2:freedom2,
  d = d * ((1.0 + a / (j - 2.0)) * z);
  if (a==1)
    p = p + d * y / (j - 1.0);
  else
    p = (p + w) * z;
  end
end
y = w * z;
z = 2.0 / z;
b = freedom2 - 2;
for i = a + 2:2:freedom1,
   j = i + b;
   d = d * (y * j / (i - 2.0));
   p = p - (z * d / j);
end
if (p < 0.0)
  p = 0.0;
else
  if (p > 1.0)
    p = 1.0;
  end
end 
prob=1.0-p;
return