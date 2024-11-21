clear;
img = imread("Fig7_data.jpg");
img = im2double(img(:,:,1));
[row,col] = size(img);

sigI2 = 0.01; sigP2 = 8; r = 2;
[Node_idx, Ncut_val] = Ncut_bright_recur(img, sigI2, sigP2, r, 0.04);

N_partitions = length(Node_idx); % 划分数量
for p=1:N_partitions
    res = zeros(row,col);
    res(Node_idx{p}) = img((Node_idx{p}));
    imwrite(res, ['7_',num2str(p),'.jpg']);
    P = zeros(row,col);
    P(Node_idx{p}) = 1;
    imwrite(P, ['7_',num2str(p),'_partition.png']);
end