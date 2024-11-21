function [node_idx_cell, Ncut_val_cell] = Partition(nodes, W, threshold)
% nodes: N*1 indices
% W: N*N  sparse, symmetric
% threshold: 1*1
N = length(nodes); % number of pixels
d = sum(W,2); % N*1
D = spdiags(d,0, N,N); % N*N

[Evec, ~] = eigs(D-W, D, 2, 'smallestabs'); 
Ev2 = Evec(:,2); clear Evec;
spl_val = median(Ev2); % 分割值 初始化为Ev2中的 中位数
func = @(x) NcutsValue(x, Ev2, W, D); % 新函数  删除NcutsVal中的其他参数
[spl_val, Ncut_val] = fminsearch(func, spl_val); % slp_val: 更小Ncut_val对应的分割值

hist = histogram(Ev2);
bins = hist.BinCounts;
%% 不宜再二分
if min(bins)/max(bins) > 0.04 || Ncut_val > threshold 
    node_idx_cell{1} = nodes; % 1*1 cell
    Ncut_val_cell{1} = Ncut_val;
    return;
end
%% 还可再二分
P1 = Ev2>spl_val; % N*1  logical{0,1}
P2 = ~P1; % N*1
[node_idx_1, Ncut_val_1] = Partition(nodes(P1), W(P1,P1), threshold);
[node_idx_2, Ncut_val_2] = Partition(nodes(P2), W(P2,P2), threshold);
node_idx_cell = cat(2, node_idx_1, node_idx_2); 
Ncut_val_cell = cat(2, Ncut_val_1, Ncut_val_2);

return;