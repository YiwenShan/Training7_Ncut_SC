clear;
N1=30; N2=10;
rand('seed',5);
x1 = 0.5.*rand(1,N1) + 1;
y1 = 0.5.*rand(1,N1) + 1.625;
x2 = 0.5.*rand(1,N1) + 1;
y2 = 0.5.*rand(1,N1) - 2.125;
x3 = 0.1.*rand(1,N2) + 1.2;
y3 = 3.25.*(rand(1,N2) - 0.5);
x4 = 2.*(rand(1,N2) - 0.5);
y4 = 0.1.*rand(1,N2) + 1.825;
X1 = [x1,x2,x3,x4; y1,y2,y3,y4];
theta = pi;
Rotate = [cos(theta) -sin(theta); sin(theta) cos(theta)]; % 逆时针旋转 pi/2
X2 = Rotate*X1;
% figure; scatter(X1(1,:), X1(2,:), 'bo');hold on;
% scatter(X2(1,:), X2(2,:), 'bo');hold off; axis('equal');
%% 
X = [X1 X2]; clear X1 X2;
sig2 = 2e-2;
k = 2;
[indicator] = SC_my(X, sig2, k);
figure; node=['bo';'rx'];
for c=1:k
    this_cls = indicator==c;
    Xc = X(:,this_cls);
    scatter(Xc(1,:), Xc(2,:), node(c,:)); hold on;
end
axis('equal'); hold off;