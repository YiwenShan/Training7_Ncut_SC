function [Ev2,spl_val] = Ncut_bright(img, sigI2, sigP2, r)
% 基于亮度 二划分
% img: H*W*1
% res: H*W*1  分类结果
[row,col] = size(img);
N = row.*col; % 像素数
r2 = r.*r;
%% 构造 W: N*N
Index = reshape(1:N, [row,col]);
W = sparse([N,N]); % 0-initalization
for j=1:col
    for i=1:row
        idx_ij = (j-1)*row + i;
        tp = max(1,i-r); bm = min(row,i+r);
        lf = max(1,j-r); rt = min(col,j+r);
        idx_covered = Index(tp:bm, lf:rt); % 覆盖的像素编号
        idx_covered = idx_covered(:);
        Nei_loc = [mod(idx_covered-1,row)+1, floor((idx_covered-1)./row)+1];
        Nsquare = (bm-tp+1)*(rt-lf+1); % 矩形覆盖的像素数
        Span = Nei_loc - repmat([i,j], [Nsquare,1]); % Nsquare * 2
        % 欧氏距离
        dis = sum(Span.*Span, 2); % Nsquare * 1
        is_nei = dis<r2; % Nsquare*1  T/F
        num_Nei = sum(is_nei); % 近邻数
        idx_Nei = idx_covered(is_nei); % idx_ij号像素的邻居像素编号
        dis_bright = img(idx_Nei) - repmat(img(idx_ij),[num_Nei,1]); % N
        W(idx_Nei, idx_ij) = exp(-dis(is_nei)./sigP2 - dis_bright.*dis_bright./sigI2);
%         W(idx_ij, idx_Nei) = W(idx_Nei, idx_ij); % 稀疏矩阵的索引很慢 ∴这句执行很慢
    end
end
for i=1:N
    W(i,i) = 0;
end
%% 图3
Dv = sum(W,2); % N*1
D = spdiags(Dv,0, N,N); % N*N  Dv的对角  [N,N]不行！！！

[Evec, ~] = eigs(D-W, D, 4, 'smallestabs');
Ev2 = Evec(:,2); clear Evec;
spl_val = 0;
func = @(x) NcutsValue(x, Ev2, W, D);
[spl_val, ncut_val] = fminsearch(func, spl_val);

return;
