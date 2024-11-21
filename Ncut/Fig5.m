clear;
N = 163; % 92 + 71
randn('seed',6);
X1 = rand(2,92);
X1(1,:) = 5.8.*X1(1,:);
X1(2,:) = 10.*X1(2,:);
X2 = rand(2,71);
X2(2,:) = X2(2,:).*10;
X2(1,:) = X2(1,:).*12.5 + 6.5;
% figure; plot(X1(1,:), X1(2,:), '^'); hold on;
% plot(X2(1,:), X2(2,:), 'x'); hold off; axis('equal');
X = [X1, X2];

sigP2 = 25; r = 3;
[P1] = Ncut_points(X, sigP2, r);
res1 = X(:,P1); 
res2 = X(:,~P1);

figure; plot(X(1,:),X(2,:),'o'); axis('equal');
figure; plot(res1(1,:), res1(2,:), '^'); hold on;
plot(res2(1,:), res2(2,:), 'x'); hold off; axis('equal');


