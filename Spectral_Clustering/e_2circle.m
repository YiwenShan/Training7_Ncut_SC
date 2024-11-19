clear;
rand('seed',5);
N1=200; N2=300; r1=0.75; r2=1.7;
theta1 = linspace(0, 2*pi, N1);
x1 = r1.*sin(theta1) + 0.4.*rand(1,N1);
y1 = r1.*cos(theta1) + 0.4.*rand(1,N1);
theta2 = linspace(0, 2*pi, N2);
x2 = r2.*sin(theta2) + 0.4.*rand(1,N2);
y2 = r2.*cos(theta2) + 0.4.*rand(1,N2);
% figure; scatter(x1,y1,'bo');hold on; scatter(x2, y2,'rx');hold off; axis('equal');
%% 
X = [x1, x2; y1, y2];
sig2 = 8e-2; 
k = 2;
[indicator] = SC_my(X, sig2, k);
figure; node=['bo';'rx'];
for c=1:k
    this_cls = indicator==c;
    Xc = X(:,this_cls);
    scatter(Xc(1,:), Xc(2,:), node(c,:)); hold on;
end
axis('equal'); hold off;
