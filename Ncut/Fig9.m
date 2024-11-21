clear;
mode = '_bic_shr2'; %   _bic_neat
img = imread(['Fig9_data',mode,'.jpg']); % 
img = im2double(img(:,:,1));
[row,col] = size(img);

sigI2 = 0.02; sigP2 = 4; r = 5; threshold = 0.08;
fprintf('sigI=%.4f  sigP=%.4f  r=%d  threshold=%.2f\n',sigI2,sigP2, r,threshold);
[Node_idx, Ncut_val] = Ncut_bright_recur(img, sigI2, sigP2, r, threshold);

N_partitions = length(Node_idx); % 划分数量
for p=1:N_partitions
    res = zeros(row,col);
    res(Node_idx{p}) = img((Node_idx{p}));
    imwrite(res, ['9_',num2str(p),mode,'.jpg']);
    P = zeros(row,col);
    P(Node_idx{p}) = 1;
    imwrite(P, ['9_',num2str(p),mode,'_partition.jpg']);
end

