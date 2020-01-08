%% load data
clc
clear;
close all
data = xlsread('grades.xlsx');
nClass =2;
 %% cluster use original data 
data1 = data';
 [labelOriginal,~,~,sumD_O,~] = litekmeans(data1,nClass,'Distance', 'cosine');
%  [labelOriginal,sumD_O] = jaccluster(data1,nClass);
 for i =1 : nClass
     Sums(i) = length(find(labelOriginal == i)); 
      temp1(i) = abs(sumD_O(i))/Sums(i);
 end
 nStu = max(Sums);
 CP1 = sum(temp1)/nClass;
[DVI] = clustering(nClass, nStu ,labelOriginal, data1);

disp(['when use original data to cluster, the DVI : ' , num2str(DVI)]);
disp(['when use original data to cluster, the CP : ' , num2str(CP1)]);
%% clustering use BIHT
 data = data;
[X_BIHT,S] = BIHT(data);
[labelBIHT,~,sumD_B,~] = kmeans(X_BIHT,nClass);
  %[labelBIHT] = jaccluster(S,nClass);
 for i =1 : nClass
     Sums(i) = length(find(labelBIHT == i));
     temp4(i) = abs(sumD_B(i))/Sums(i);
 end
 nStu = max(Sums);
  CP4 = sum(temp4)/nClass;
[DVI] = clustering(nClass, nStu ,labelBIHT, X_BIHT);
disp(['when use BIHT to cluster, the DVI : ' , num2str(DVI)]);
disp(['when use BIHT data to cluster, the CP : ' , num2str(CP4)]);

%% sparfa
dataSparfa = load('sparfa.txt');
dataSparfa = dataSparfa';
   [labelSparfa,~,~,sumD_Spa,~] = litekmeans(dataSparfa,nClass,'Distance', 'cosine');
%   [labelSparfa,sumD_Spa] = jaccluster(dataSparfa,nClass);
 for i =1 : nClass
     sums(i) = length(find(labelSparfa == i));
     temp2(i) = abs(sumD_Spa(i))/sums(i);
 end
 nStu = max(sums);
 CP2 = sum(temp2)/nClass; 
[DVI] = clustering(nClass, nStu ,labelSparfa,dataSparfa);
disp(['when use sparfa to cluster, the DVI : ' , num2str(DVI)]);
disp(['when use sparfa to cluster, the CP : ' , num2str(CP2)]);

%% clustering use SFL
 SUM = 0;
 for iter = 1:50
 [err, D, X_SFL, W, J] = runDemo(data, 0.03, 0.4, 0.2, 500,50, 1.3 ,30);
   D_Nor = NormalizeFea(D, 1);
  D_Nor= (D_Nor < 0.001) .* 0 + (D_Nor>= 0.001).*D_Nor;
 X_SFL_new = X_SFL';
    [labelSFL,~,~,sumD_SFL,~] = litekmeans(X_SFL_new,nClass,'Distance', 'cosine');
     [labelSFL,sumD_SFL] = jaccluster(X_SFL_new,nClass);
 
  for i =1 : nClass
      sums(i) = length(find(labelSFL == i));
      temp3(i) = abs(sumD_SFL(i))/sums(i);
  end
  nStu = max(sums);
  CP3 = sum(temp3)/nClass; 
 [DVI] = clustering(nClass, nStu ,labelSFL, X_SFL_new);
 SUM = SUM + CP3;
 disp(['when use SFL to cluster, the DVI : ' , num2str(DVI)]);
 save('SFL_label','labelSFL');
 
 end
 sumDVI = sum/50;
 sumCP3 = SUM/50;
 disp(['when use SFL to cluster, the sumCP : ' , num2str(sumCP3)]);

%% question_meta knowledge
 T = xlsread('Exam_knowledge.xlsx');
 [n,t] = size(T);
for i = 1:t
    temp = T(:,i);
   temp1 = lasso(D_Nor,temp);
   a1 = temp1(:,25);
    A(:,i) = a1;
end
  A = abs(A);
U = X_SFL_new * A;
U_Nor = NormalizeFea(U, 1);
 %% »Ö¸´Ô­±¾´ðÌâÇé¿ö
Y1 = D_Nor*X_SFL;
YRecovery = 1.0 ./ (1 + exp(-Y1));
 YRecovery(YRecovery>=0.5) = 1;
 YRecovery(YRecovery<0.5) = 0;
