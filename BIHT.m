function [D,X] = BIHT(data)
format long;

data(data == 0) = -1;
%%%%%%%%%%%%%%%parameters
N= 500; %%%%Length of the signal
[n, T] = size(data);
A = randn(n,N); Y = data;
S=pinv(A) * Y;
%M=20;%%%%Number of bits  
%T=536; 
p=.1;

K=500;
%%%%%%%%%%Blind dictionary of sparse signal
%rand('twister',5589);
phi=rand(N,K);
%index = randperm(N*K, int32(N*K*0.51));
%phi(index) = -phi(index);
for i=1:K
    phi(:,i)=phi(:,i)./norm(phi(:,i));
end

mid = rand(N,K);
%rand('twister',5589);
% index = randperm(N*K, int32(N*K*0.49));
% mid(index) = -mid(index);
phi_hat=phi+.01*mid;
D=A*phi_hat;

for k=1:T

y=Y(:,k);
shat0 = pinv(D)*y;
shat0=maxk_fun(shat0,round(p*N));
%%%%%%%%%%%%%%BIHT
num_it=10;
taw=1;
shat21 = BIHT_fun( y,D,num_it,taw,p );
shat2(:,k)=shat21./norm(shat21);
end
%%%%%%%%%%%%%%DL-BIHT
mu=1e0;
num_iter=20;
for nsim=1:num_iter    
%%%%%%%DL update  
D_prev=D';
for j=1:n
    dj=D(j,:)';
    for i=1:T
        si=shat2(:,i);
        ei=Y(j,i)-S_fun(dj'*si);
        dj=dj+mu*si.*Sp_fun(dj'*si).*ei;
    end
    D(j,:)=dj';
end
%%%%%%%%%%one bit CS    
for k=1:T
y=Y(:,k);
% initial guess = min energy
shat0 = pinv(D)*y;
shat0=maxk_fun(shat0,round(p*N));

%%%%%%%%%%%%%%BIHT
num_it=10;
taw=1;
tic
shat21 = BIHT_fun( y,D,num_it,taw,p ); %% ¸üÐÂsi
shat2(:,k)=shat21./norm(shat21);
time_BIHT=toc;
end
%MSE_BIHT=20*log10(norm(shat2(:,T)-S(:,T)));
end

%MSE_BIHT=20*log10(norm(shat2(:,T)-S(:,T)));
X = phi * S;
% figure;plot(X(:,T));hold on;plot(phi*shat2(:,T),'r');
% legend('Original Signal','Reconstructed Signal');hold off;
end

