function [err, D, X, W, J] = runDemo(data, lambda1, lambda, mu, k, s, alpha , maxIter)
%% update one bit algorithm
clear para;

[n,m] = size(data);
% ³õÊ¼»¯¾ØÕóD
col = k;
lin = n;
p1 = rand(lin,col);
for i=1:lin
    for j = 1:col
	   if p1(i,j)>=0.5 
        p1(i,j) = 1;
     else
        p1(i,j) = 0;
    end
    end
end
D = p1; 
W = sparse(n,m);
M = zeros(n,m); 
Y = data; X = pinv(D) * Y;
tol1 = 6;
iter = 0;    
while(tol1 > 1e-4 && iter < maxIter)
    iter = iter + 1;   
    %% update J
    temp = W-M/mu;
    J = max(0, temp - lambda1/mu) + min(0, temp + lambda1/mu); 
    
    %% update W
    temp = D * X + W; temp = -temp;
    S = 1 ./ (1 + exp(20*temp)); 
    Spie =  exp(20*temp) ./ (1 + exp(20*temp)).^2;
    L2 = 2*(Y - S) .* Spie*(-1) + mu *(W - (J + M / mu));
    W = W - alpha * L2;
   
    %% update X
    for i = 1 : m
        y = Y(:,i);
       shat2 = hard_l0_Mterm(y,D,k,s);
       shat21(:,i) = max(shat2,0);
%        shat2(:,i) = shat21(:,1)./norm(shat21(:,1));
    end
    X = shat21;
    
    %% update D
   
    for p = 1 : m
        for i = 1 : n
            temp = D(i,:);
            temp = temp * X(:,p);
            temp = temp + W(i,p);
            temp = - temp;
            S = 1 ./(1 + exp(20*temp));
            Spie =  exp(20*temp) ./(1 + exp(20*temp)).^2 ;
            Spie = Spie .* X(:,p)*(-1);
            L = 2 * (Y(i,p) - S) * Spie;
            D(i,:) = D(i,:) - lambda * L';
        end
        if(length(find(isnan(D))) > 0)
            disp(['p is : ', num2str(p)]);
        end
    end
    indexD = (D < 0);
    D(indexD) = 0;
%     D = (D >= 0).*1 + (D < 0 ).*0;
    %% update M
    M = M + mu * (W - J);
    
%     %% update mu
%     rho = 0.3;
%     muMax = 10e6;
%     mu = min(rho * mu , muMax);
    
    %% RMSE
    %%%%%%%%%%Calculate error  
%     su=0;
%     for i=1:m
%         mid1 = D*X(:,i) + W(:,i);
%         mid = LiteSign(mid1);
%         su=su+(norm(Y(:,i)-mid) ) ^2;
%     end
    SU = 0;
    num = m * n;
    mid = D * X + W;
    mid1 = LiteSign(mid);
    for i = 1 : n
        for j = 1 : m
            SU = SU + (Y(i,j) - mid1(i,j)).^2;
        end
    end
    su = sqrt(SU/num);
    err(iter,1)=su;  
end
plot(err);
xlabel('iter');
ylabel('err');
end

