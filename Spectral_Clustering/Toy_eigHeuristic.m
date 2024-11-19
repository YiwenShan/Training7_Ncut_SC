clear;
randn('seed',5);
Nc = 50;
x1 = randn(1,Nc) + 3;
y1 = randn(1,Nc) + 2;
x2 = 2.*(randn(1,Nc) - 0.5) - 3;
y2 = randn(1,Nc) - 1;
x3 = randn(1,Nc) + 3;
y3 = 2.*(randn(1,Nc) - 0.5) - 2;
mx1 = mean(x1); mx2 = mean(x2); mx3 = mean(x3);
my1 = mean(y1); my2 = mean(y2); my3 = mean(y3);
x1=x1-mx1; x2=x2-mx2; x3=x3-mx3;
y1=y1-my1; y2=y2-my2; y3=y3-my3;
figure; plot(x1,y1,'o'); hold on;
plot(x2,y2,'^'); hold on; 
plot(x3,y3, 's'); axis('equal'); hold off;
%%
X = [x1 x2 x3; y1 y2 y3];
N = size(X,2); 
X2 = sum(X.*X, 1); % 1*N
dist = repmat(X2, [N,1]) + repmat(X2', [1,N]) - 2.*X'*X; % N*N
sig2 = 1;
%% 全连接
% A = exp(dist./(-sig2)); % N*N  affinity matrix
% for i=1:N; A(i,i)=0; end
%% kNN
k = 8;
[~, idx_nei] = sort(dist); % N*N
idx_nei = idx_nei(:,2:k+1); % k*N
A = zeros(N,N);
for j=1:N
    A(idx_nei,j) = exp(dist(idx_nei,j)./(-sig2));
end
%%
d = sum(A,2); % N*1
Lrw = eye(N) - diag(1./d)*A;
[Evec, Eval] = eig(Lrw); % N*N
Eval = diag(Eval);
[~,idx] = sort(Eval);
Eval = Eval(idx); Evec = Evec(:,idx);
figure; plot(Eval(1:10), '*', 'MarkerSize',10); ylim([0,Eval(10)]);

