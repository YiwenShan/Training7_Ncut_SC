clear;
N1=100; N2=250; N3=400; N4=30;
r1=0.35; r2=1; r3=2;
theta1 = linspace(0, 2*pi, N1);
rand('seed',5);
x1 = r1.*sin(theta1) + 0.2.*rand(1,N1);
y1 = r1.*cos(theta1) + 0.2.*rand(1,N1);
theta2 = linspace(0, 2*pi, N2);
x2 = r2.*sin(theta2) + 0.2.*rand(1,N2);
y2 = r2.*cos(theta2) + 0.2.*rand(1,N2);
theta3 = linspace(0, 2*pi, N3);
x3 = r3.*sin(theta3) + 0.2.*rand(1,N3);
y3 = r3.*cos(theta3) + 0.2.*rand(1,N3);
x4 = 0.25.*(rand(1,N4) - 0.5);
y4 = rand(1,N4) + 1;
% figure; scatter(x1,y1,'bo');hold on; 
% scatter([x2,x3,x4], [y2,y3,y4],'rx');hold off; axis('equal');
%% 
X = [x1,x2,x3,x4; y1,y2,y3,y4];
sig2 = 2e-2; k = 2;
% sig2 = 2.4e-2; k = 3;
[indicator] = SC_my(X, sig2, k);
figure; node=['bo';'rx'; 'g^'];
for c=1:k
    this_cls = indicator==c;
    Xc = X(:,this_cls);
    scatter(Xc(1,:), Xc(2,:), node(c,:)); hold on;
end
axis('equal'); hold off;