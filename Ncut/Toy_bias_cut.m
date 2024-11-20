clear;
Nc = 30;
randn('seed',6);
x1 = randn(1,Nc).*0.2;
y1 = randn(1,Nc).*0.1;
x2 = randn(1,Nc).*0.1 + 1;
y2 = randn(1,Nc).*0.2;
X = [x1 x2; y1 y2];
%% cut
% N = size(X,2);
% X2 = sum(X.*X, 1); % 1*N
% dist = repmat(X2,[N,1]) + repmat(X2',[1,N]) - 2.*X'*X; % N*N
% sig2 = 1;
% W = exp(dist./(-sig2));
% for i=1:N; W(i,i)=0; end
% W = (W + W')./2;
% gt = sum(sum(W(Nc+1:N,1:Nc)));
% W2 = sum(W,2);
% [~,idx] = sort(W2);
% mcut = idx(1);
% figure;scatter(x1,y1,'bo','Markerfacecolor','b');hold on;scatter(x2,y2,'rs','Markerfacecolor','r');axis('equal');hold off;
% figure;scatter(X(1,[1:mcut-1, mcut+1:N]), X(2,[1:mcut-1, mcut+1:N]), 'bo','Markerfacecolor','b'); hold on;
% scatter(X(1,mcut), X(2,mcut),'rs','Markerfacecolor','r'); axis('equal');hold off;
%% Ncut
sigP2 = 0.01;
r = 1;
[P1] = Ncut_points(X,sigP2,r);
P2 = ~P1;
figure; scatter(X(1,P1), X(2,P1), 'bo','Markerfacecolor','b'); hold on;
scatter(X(1,P2), X(2,P2),'rs','Markerfacecolor','r'); axis('equal');hold off;
