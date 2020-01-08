function [DVI] = clustering(nClass, nStu , label , subspace)
%CLUSTERING 此处显示有关此函数的摘要
%   此处显示详细说明
num = zeros(nClass , nStu);
 for i = 1 : nClass
     mid = find(label == i);
     len = length(mid);
     for j = 1: len
         num(i,j) = mid(j);
     end
 end
 
 % 类间距
 index = 0;
 for i = 1 : nClass
     for j  = 1 : nClass
         if (i ~= j)
             index = index + 1;
             [distance] = dviDistance(num(i,:),num(j,:),subspace);
             minDis(index) = min(min(distance));
         end
     end
 end
 
 without = min(minDis);

 % 类内最大距离
  index = 0;
 for i = 1 : nClass
     index = index + 1;
     [distance] = dviDistance(num(i,:),num(i,:),subspace);
     maxDis(index) = max(max(distance));
 end
 
 within = max(maxDis);
 
 DVI = without / within;
end

