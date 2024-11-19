clear;
theta = pi/6:-pi/24:-pi*13/12; % 椭圆弧
N1 = length(theta); % 椭圆弧上的样本数
rand('seed',5);
theta = theta + (rand(1,N1)-0.5).*0.01; % 角度上的噪声扰动
a = 1.7; % 椭圆半长轴
b = 1.35; % 椭圆半短轴
rho = a*b./sqrt(b*b.*cos(theta).*cos(theta) + a*a.*sin(theta).*sin(theta)); % 1*N1
x1 = rho.*cos(theta); 
y1 = rho.*sin(theta);
% figure; scatter(x1,y1,'bo'); axis('equal');
N2 = 45;
x2 = 0.9.*(rand(1,N2) - 0.5) + 0.8;
y2 = 1.1.*(rand(1,N2) - 0.5);
x3 = rand(1,N2) - 0.5 - 0.8;
y3 = 1.2.*(rand(1,N2) -0.5);
%%
X = [x1,x2,x3; y1,y2,y3]; %figure;scatter(X(1,:),X(2,:),'bo');axis('equal');
sig2 = 1e-2; k = 3;

[indicator] = SC_my(X, sig2, k);
figure; node=['bo';'rx'; 'g^'];
for c=1:k
    this_cls = indicator==c;
    Xc = X(:,this_cls);
    scatter(Xc(1,:), Xc(2,:), node(c,:)); hold on;
end
axis('equal'); hold off;