clear;
sig = 0.2;
img = zeros(20,20);
randn('seed',3);
img(:,1:5) = 0.8 + sig.*randn(20,5);
img(:,6:20) = 0.2 + sig.*randn(20,15);
m = min(min(img)); M = max(max(img));
img = (img-m)./(M-m);
% imshow(img);
r = 2;
sigI2 = 0.02; sigP2 = 4; 
[Ev2, spl_val] = Ncut_bright(img, sigI2, sigP2, r);
P1 = Ev2>spl_val;
m = min(Ev2); M = max(Ev2);
Ev2 = (Ev2-m)./(M-m);
Ev2_img = reshape(Ev2,20,20);
figure; imshow(Ev2_img);
% imwrite(Ev2_img, ['Fig6_eigvec.png']);
res = zeros(20,20); res(P1) = 1; figure;imshow(res);





