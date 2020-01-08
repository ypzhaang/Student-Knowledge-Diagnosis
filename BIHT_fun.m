function shat = BIHT_fun( y,A,num_it,taw,p )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

si=size(A);
N=si(1,2);


shat2=zeros(N,1);
%taw=1;
K=round(p*N);

for l=1:num_it
    A_xl=sign(A*shat2);
    a_lp1=shat2+(taw/2)*A'*(y-A_xl);
    shat2=maxk_fun(a_lp1,K);
end 

shat=shat2;

