clear

%% parameters
Q = 15;
K = 50;
N = 10;
q = 0.2;

%% Generating Dictionary 
   D = randn(Q,K);
   D_Nor_Orin = NormalizeFea(D, 1);

%% Generating sparse vector X
% for j = 1:N
%     sl_x = q * K;
%     x = zeros(K,1);
%     [V, I] = sort(abs(randn(K,1)),'descend');
%     x(I(1:sl_x)) = randn(sl_x,1);
%     x = x./norm(x);
%     X(:,j) = x;
% end
X = zeros(K,N);
X(1:25,1:5) = randn(25,5); X(26:50,6:10) = randn(25,5);
X = NormalizeFea(X,2);
X = max(X,0);
%% Generating sparse matrix W
sl_W = q * N;
i = randperm(sl_W);
j = randperm(sl_W);
s = randn(sl_W,1);
W = sparse(i,j,s,Q,N);
W = full(W);
W =  W./norm(W,'fro');
%% Generating Y
Y = sign(D*X + W);
Y = (Y+1)/2;
save('response','Y');
%% SFL model
[err, D_hat, X_SFL, W_hat, J] = runDemo(Y, 0.03, 0.4, 0.2, 50, 25, 1.3 ,30);
D_Nor = NormalizeFea(D_hat, 1);
D_Nor= (D_Nor < 0.001) .* 0 + (D_Nor>= 0.001).*D_Nor;
save('X_SFL','X_SFL');
E_D = norm(D-D_hat,'fro')./norm(D,'fro');
E_X = norm(X-X_SFL,'fro')./norm(X,'fro');
E_W = norm(W-W_hat,'fro')./norm(W,'fro');

[labelD] = litekmeans(D_Nor,5);

 for i =1 : 5
     sums(i) = length(find(labelD == i));
 end
 nStu = max(sums);
 
[DVI] = clustering(5, nStu ,labelD,D_Nor);

disp(['when use SFL to cluster, the DVI : ' , num2str(DVI)]);


