function Ncut = NcutsValue(split_point, Ev2, W, D)
% Output: Ncuts的值
x = Ev2>split_point; % N*1  {0,1}
x = 2.*x - 1; % N*1  {-1,1}
d = spdiags(D,0); % N*1
b = sum(d(x>0))/sum(d(x<0)); % 1*1
y = 1 + x - b.*(1 - x); % N*1
Ncut = (y'*(D - W)*y)/sum(y.*y.*d);
% CutAB=sum(sum(W(x>0,x<=0)));assocA=sum(sum(W(x>0,:)));assocB=sum(sum(W(x<=0,:)));Ncut2=CutAB*(1/assocA+1/assocB);

return;