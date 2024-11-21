function cut = cutsValue(split_point, Ev, W)
% 
x = Ev > split_point;
y = ~x;
x = double(x); y = double(y);
cut = x'*W*y;

return;