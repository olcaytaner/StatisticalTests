function prob = qdist(q, v,r)
%probability value = qdist(q, freedom1, freedom2)
%Returns the probability of studentized range distribution with value of q and 
%with degree of freedoms v and r.
pcutj=0.00003;
pcutk=0.0001;
step=0.45;
vmax=120.0;
fifth=0.2;
cv1=0.193064705;
cv2=0.293525326;
cvmax=0.39894228;
cv=[0.318309886,-0.00268132716,-0.00347222222,0.0833333333];
jmin=3;
jmax=15;
kmin=7;
kmax=15;
prob=0;
if q<=0,
  return 
end  
g = step*(r.^(-fifth));
gmid = 0.5*log(r);
r1=r-1;
c=log(r*g*cvmax);
if c<vmax,
  h=step*(v.^(-0.5));
  v2=v*0.5;
  if v==1,
    c=cv1;
  else
    if v==2,
      c=cv2;
    else
      c=sqrt(v2)*cv(1)/(1+((cv(2)/v2+cv(3))/v2+cv(4))/v2);
    end
  end    
  c=log(c*g*r*h);
end
gstep=g;
qw(1)=-1;
qw(jmax+1)=-1;
pk1=1;
pk2=1;
for k=1:kmax,
  gstep=gstep-g;
  op2=0;
  while (gstep>0) | (op2==0),
    gstep=-gstep;
    gk=gmid+gstep;
    pk=0;
    if (pk2>pcutk)|(k<=kmin),
      w0=c-0.5*gk*gk;
      pz=normal(gk,1);
      x=normal(gk-q,1)-pz;
      if x>0,
        pk=exp(w0+r1*log(x));
      end  
      if v<=vmax,
        jump=-jmax;
        op=0;
        while (h<0)|(op==0),
          jump=jump+jmax;
          for j=1:jmax,
            jj=j+jump;
            if qw(jj)<=0,
              hj=h*j;
              if j<jmax,
                qw(jj+1)=-1;
              end  
              ehj=exp(hj);
              qw(jj)=q*ehj;
              vw(jj)=v*(hj+0.5-0.5*ehj*ehj);
            end
            pj=0;
            x=normal(gk-qw(jj),1)-pz;
            if x>0,
              pj=exp(w0+vw(jj)+r1*log(x));
            end  
            pk=pk+pj;
            if pj<=pcutj,
              if (jj>jmin)|(k>kmin),
                break;
              end
            end     
          end
          h = -h;
          op = op + 1;
        end
      end
    end
    prob=prob+pk;
    if (k>kmin)&(pk<=pcutk)&(pk1<=pcutk),
      return
    end  
    pk2=pk1;
    pk1=pk;
    op2 = op2 +1;
  end
end