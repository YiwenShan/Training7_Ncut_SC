clear;
mode = 'bicu_shr'; % '' detail2
I = im2double(imread(['baseball_8000_',mode,'.jpg'])); %  _75_110
I = rgb2gray(I);
sigI2 = 0.01; sigP2 = 16; r = 5;
[Node_idx, Ncut_val] = Ncut_bright_recur(I,sigI2, sigP2, r, 0.04);

[row,col] = size(I);
N_partitions = length(Node_idx); % 划分数量
for p=1:N_partitions
    res = zeros(row,col);
    res(Node_idx{p}) = I((Node_idx{p}));
    imwrite(res, ['4_',num2str(p),'_',mode,'.jpg']);
end

