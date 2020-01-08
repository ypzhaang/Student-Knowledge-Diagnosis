clc
clear
close all
%% MA classification
for iter = 1:10
data = xlsread('StudentReponses1.xlsx');
[m,~] = find(isnan(data));
data(m,:) = [];
datause = data;
data = datause';
% grade = data(1,:);
% data(1,:)=[];
num6 = round(length(find(data(1,:)==6))*0.08);
num7 = round(length(find(data(1,:)==7))*0.49);
num8 = round(length(find(data(1,:)==8))*0.39);
num10 = round(length(find(data(1,:)==10))*0.04);

count6 = find(data(1,:)==6);
six = count6(randperm(num6));
count7 = find(data(1,:)==7);
seven = count7(randperm(num7));
count8 = find(data(1,:)==8);
eight = count8(randperm(num8));
count10 = find(data(1,:)==10);
ten = count10(randperm(num10));
%% testing set
col = [six, seven, eight,ten];
testing = data(:,col);
testing(1,:) = [];
%% training set
train = data;
train(:,col) = [];

%% train model

n = 350;
R = randperm(n);
dataSet = train(:,R);
dataSet(1,:) =[];

ques = randperm(25);
res_p = testing(ques(1),:);
orig = dataSet(ques(1),:);
dataSet(ques(1),:)=[];
testing(ques(1),:) = [];
[n, m] = size(testing);
[p ,q] = size(dataSet);
for i = 1:m
    for j =1:q
     dis(i,j) = sqrt(sum((dataSet(:,j) - testing(:,i)).^2));
    end
end
[row, col] = size(dis);
for k = 1:row
    a = dis(k,:);
    [val, ind] = sort(a);
    A(k,:) = ind;
end
for h = 1:row
    index = A(:,1);
    Y_pre(:,h) = orig(:,index(h));
end
Y_res = res_p;
err = 0;
for l = 1:row
    if(Y_pre(l)~=Y_res(l))
        err = err+1;
    end
rato = err/m;
end
fprintf('´íÎóÎª: %f',rato) 
iter = iter +1;
end