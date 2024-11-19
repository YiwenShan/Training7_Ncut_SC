clear;
N = 70;
rand('seed',5);
x1 = 0.4.*(rand(1,N) - 0.5) + 0.4; 
y1 = 0.6.*(rand(1,N) - 0.5) - 0.3;
x2 = 0.4.*(rand(1,N) - 0.5) + 2; 
y2 = 0.6.*(rand(1,N) - 0.5) - 0.3;
x3 = 0.4.*(rand(1,N) - 0.5) + 1.2;
y3 = 0.6.*(rand(1,N) - 0.5) + 0.3;
x4 = rand(1,4*N).*(0.75*pi);
y4 = sin(4.*x4);
% figure; scatter(x1,y1,'bo');hold on; scatter(x2, y2,'rx');hold on; 
% scatter(x3, y3,'g^');hold on; scatter(x4,y4,'ks'); hold off; axis('equal');
%% 
X = [x1,x2,x3,x4; y1,y2,y3,y4];
sig2 = 1e-3; k = 4;
[indicator] = SC_my(X, sig2, k);
figure; node=['bo';'rx'; 'g^'; 'ks'];
for c=1:k
    this_cls = indicator==c;
    Xc = X(:,this_cls);
    scatter(Xc(1,:), Xc(2,:), node(c,:)); hold on;
end
axis('equal'); hold off;