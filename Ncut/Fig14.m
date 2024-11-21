clear;
% rand('seed',16);
% x1 = rand(1,20).*0.5; x1 = sort(x1);
% x2 = rand(1,12).*0.35 + 0.65; x2 = sort(x2);
% N = length(x1) + length(x2); % 样本数
randn('seed',4);
N = 32;
x = randn(1,N);
x1 = x(1:20); x2 = x(21:N); clear x;
x1 = sort(x1); x2 = sort(x2);
mn = min(x1); mx = max(x1);
x1 = (x1-mn)./(mx-mn);
x1 = x1.*0.5;
mn = min(x2); mx = max(x2);
x2 = (x2-mn)./(mx-mn);
x2 = x2.*0.35 + 0.65;
%%
X = [x1, x2; ones(1,N)]; clear x1 x2;
X2 = sum(X.*X,1); % 1*N
dist = repmat(X2, [N,1]) + repmat(X2', [1,N]) - 2.*X'*X; % N*N
% W = exp(dist./(-0.01)); % N*N
W = ones(N,N) - sqrt(dist); % N*N
% W = exp(sqrt(dist)./(-0.2)); % N*N
x=0:0.02:1;
y1 = exp(x.*x./(-0.01));
y2 = 1-x;
y3 = exp(x./(-0.2));
figure; plot(x,y1, ':', 'Linewidth',2); hold on;
plot(x,y2, '-', 'Linewidth',4); hold on;
plot(x,y3, ':', 'Linewidth',2); hold off; 
xlim([0,1]); ylim([0,1]);axis('equal');

figure; heatmap(W);
% figure; plot(X(1,:), X(2,:), '^'); % 
%%
Dv = sum(W,2); % N*1
D = diag(Dv); % N*N
[Ev_Ncut, ~] = eig(D-W, D); % Ncut
[Ev_Acut, ~] = eig(D-W); % Average Cut
[Ev_AAssoc, ~] = eig(W); % Average Association
%%
figure;
subplot(321); plot(1:N, Ev_Ncut(:,1), '^'); 
% ylim([-0.0683,-0.0682]); % W1
ylim([0.03761, 0.03762]); % W2
% ylim([-0.05238, -0.052378]); % W3
subplot(322); plot(1:N, Ev_Ncut(:,2), '^');

subplot(323); plot(1:N, Ev_Acut(:,1), '^'); 
% ylim([0.17677, 0.17678]); % W1
ylim([-0.17678, -0.17677]); % W2
% ylim([0.17677, 0.17678]); % W3
subplot(324); plot(1:N, Ev_Acut(:,2), '^');

subplot(325); plot(1:N, Ev_AAssoc(:,1), '^'); 
subplot(326); plot(1:N, Ev_AAssoc(:,2), '^');