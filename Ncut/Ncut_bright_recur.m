function [Node_idx, Ncut_val] = Ncut_bright_recur(img, sigI2, sigP2, r, threshold)
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
%         dbstop in Ncut_bright_recur at 15 if idx_ij==1990
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
    end
end
for i=1:N
    W(i,i) = 0;
end
%% 递归 (图4)
Nodes = (1:N)'; % N*1
[Node_idx, Ncut_val] = Partition(Nodes, W, threshold);

return;