function [ y ] = maxk_fun( x,K )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

y=x;
si=size(x);
N=si(1,1);

[m ind]=sort(abs(x));
y(ind(1:N-K))=0;


end

