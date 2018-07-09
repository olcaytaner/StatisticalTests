function prob=chi(x, freedom)
%probability value = chi(x, freedom)
%Returns the probability of chi-square distribution with value of x and 
%with degree of freedom freedom.
%Returns 1 if x < 0 or freedom < 1
if (x <= 0.0 | freedom < 1)
  prob = 1.0;
  return
end  
a = 0.5 * x;
if (freedom > 1)
  y = exp(-a);
end  
if (mod(freedom, 2) == 0)
  s = y;
else
  s = (2.0 * znormal(-sqrt(x)));
end
if (freedom > 2)
  x = 0.5 * (freedom - 1.0);
  if (mod(freedom, 2) == 0)
    z = 1.0;
  else
    z = 0.5;
  end  
  if (a > 20)
    if (mod(freedom, 2) == 0)
      e = 0.0;
    else
      e = 0.5723649429247000870717135;
    end  
    c = log(a);
    while z <= x,
      e = log (z) + e;
      s = s + exp (c*z-a-e);
      z = z + 1.0;
    end
    prob = s;
  else
    if (mod(freedom, 2) == 0)
      e = 1.0;
    else
      e = (0.5641895835477562869480795 / sqrt (a));
    end  
    c = 0.0;
    while z <= x,
       e = e * (a / z);
       c = c + e;
       z = z + 1.0;
    end
    prob = (c * y + s);
  end
else
  prob = s;
end