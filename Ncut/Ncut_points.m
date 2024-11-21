function [P1] = Ncut_points(X, sigP2, r)
% 点集的二划分
% X: D*N  D:维数  N: 样本数
% P1: N*1  二分类中的第一类
[dim,N] = size(X);
r2 = r.*r;
%% 构造 W: N*N
X2 = sum(X.*X, 1); % 1*N
dist = repmat(X2,[N,1]) + repmat(X2',[1,N]) - X'*X.*2;
W = sparse(N,N); % 0-initalization
for j=1:N % for each sample
    dis_j = dist(:,j); % N*1
    Nei_j = find(dis_j<r2);
    W(Nei_j,j) = exp(-dis_j(Nei_j)./sigP2);
end
for i=1:N
    W(i,i) = 0;
end
%% 递归
% Nodes = (1:N)'; % N*1
% [Node_idx, Ncut_val] = Partition(Nodes, W, 0.04);
%% 图5
Dv = sum(W,2); % N*1
D = spdiags(Dv,0, N,N); % N*N  Dv的对角  [N,N]不行！！！
Nevl = 2; % 特征值的数量
[Evec, ~] = eigs(D-W, D, Nevl, 'smallestabs');
Ev2 = Evec(:,2); clear Evec;
spl_val = median(Ev2);
func = @(x) NcutsValue(x, Ev2, W,D);
spl_val = fminsearch(func, spl_val);
P1 = Ev2>spl_val; % N*1  logical{0,1}

return;