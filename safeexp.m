function result = safeexp(x)
if x<-20
  result = 0;
else
  result = exp(x);
end