function [indicator] = SC_my(X, sig2, k)
% X: D*N  D features  N samples
% sig2: 1*1  variance
% indicator: N*1  clustering indicator for each sample
N = size(X,2); % number of samples
X2 = sum(X.*X, 1); % 1*N
dist = repmat(X2, [N,1]) + repmat(X2', [1,N]) - 2.*X'*X; % N*N
A = exp(dist./(-sig2)); % N*N  affinity matrix
for i=1:N; A(i,i)=0; end

D12 = sum(A,2); % N*1
D12 = sqrt(D12);
L = diag(1./D12)*A*diag(1./D12);
L = (L + L')./2;

[Evec, ~] = eig(L); % N*N
Evk = Evec(:,N:-1:N-k+1); % N*k 
Ev2 = sqrt(sum(Evk.*Evk,2)); % N*1
Y = diag(1./Ev2) * Evk; % N*k
% figure;scatter(Y(:,1), Y(:,2),'+');axis('equal')
indicator = kmeans(Y,k);

return;
