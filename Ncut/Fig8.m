clear;
mode = '_bic_shr'; %   _bic_neat
img = im2double(imread(['Fig8_data',mode,'.jpg'])); % 
[row,col] = size(img);

sigI2 = 0.007; sigP2 = 15; r = 10;
[Node_idx, Ncut_val] = Ncut_bright_recur(img, sigI2, sigP2, r, 0.08);

N_partitions = length(Node_idx); % 划分数量
for p=1:N_partitions
    res = zeros(row,col);
    res(Node_idx{p}) = img((Node_idx{p}));
    imwrite(res, ['8_',num2str(p),mode,'.jpg']);
    P = zeros(row,col);
    P(Node_idx{p}) = 1;
    imwrite(P, ['8_',num2str(p),mode,'_partition.png']);
end

