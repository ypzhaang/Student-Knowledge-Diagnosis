clc
clear
close all
%% MA classification
data = xlsread('StudentReponses1.xlsx');
[row,col] = size(data);
[m, n] = find(isnan(data));
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
train(1,:) = [];