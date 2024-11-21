clear;
img = im2double(imread(['baseball_75_110.jpg'])); %  
img = rgb2gray(img);
sigI2 = 0.01; sigP2 = 16; r = 5;
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
Nevl = 9; % 特征值的数量
[Evec, Eval] = eigs(D-W, D, Nevl, 'smallestabs');
Eval = diag(Eval);

figure; plot(Eval(1:Nevl), 'o-');ylim([0,Eval(Nevl)*1.1]);
xlabel('eigenvector'); ylabel('eigenvalue');
for i=2:Nevl
    evImg = reshape(Evec(:,i), row,col);
    mn = min(min(evImg)); mx = max(max(evImg));
    mx_mn = mx - mn;
    evImg = (evImg-mn)./mx_mn;
    imwrite(evImg, ['3_', num2str(i),'.png']);
end

