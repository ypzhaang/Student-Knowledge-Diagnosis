%%
clc
clear
close all
%%
data = xlsread('grades.xlsx');
[m,n] = size(data);
train_number = 10;
% data_train = zeros(m,train_number);
iter = 0; SUM = 0;
while(iter<=15)
 j = randperm(n);
 Index = j(1:train_number);
data_train(:,1:train_number) = data(:,Index);  
data1 = data;
data1(:,Index) = [];
data_text = data1;
[~, D_train, X_SFL_train, W, ~] = runDemo(data_train, 0.03, 0.4, 0.2, 500, 50, 1.3 ,30);
 % D_Nor = NormalizeFea(D_train, 1);
 % X_SFL_train = NormalizeFea(X_SFL_train, 2);
q1 = size(data_train,2);
r = randperm(m);
res = data_text(r(1),:);
data_text(r(1),:) = [];
data_train1 = data_train;
data_train1(r(1),:) = [];
data_text1 = data_text;
data_train2 = data_train1;
q2 = size(data_text1,2);
dis = zeros(q1,1);
err = 0;
for k = 1:q2
    for j = 1:q1
        dis(j,1) = sqrt(sum((data_text1(:,k) -data_train2(:,j) ).^2));
    end
    [val,ind] = sort(dis,'descend');
    Y_res = D_train(r(1),:)  * X_SFL_train(:,ind(1));
    Y_pre = (Y_res>0).*1 + (Y_res<0).*0; 
%     fprintf('测试结果为：%d  真实结果为：%d\n',[Y_pre res(k)])
    if(res(k)~=Y_pre)
        err = err+1;
    end
end
 rito = err/(n-train_number);
 SUM = SUM + rito;
  iter = iter+1;
 end          
   fprintf('错误为: %f',SUM/15)     