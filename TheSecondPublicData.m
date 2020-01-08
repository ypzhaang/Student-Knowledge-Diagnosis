clear
close all
%% data set
data = xlsread('StudentReponses1.xlsx');
[row,col] = size(data);
[m,n] = find(isnan(data));
data(m,:) = [];
grade = data(:,1);
data(:,1) = [];
datause = data;
data = data';
nClass = 3;
%% do SFL
[err, D, X_SFL, W, J] = runDemo(data, 0.03, 0.4, 0.2, 500,50, 1.3 ,30);
 D_Nor = NormalizeFea(D, 1);
 D_Nor= (D_Nor < 0.001) .* 0 + (D_Nor>= 0.001).*D_Nor;
 X_SFL_new = X_SFL';
 [labelSFL,~,sumD_SFL,~] = kmeans(X_SFL_new,nClass);
%  for i =1 : nClass
%      clusternum(i) = length(find(labelSFL == i));
%      j =1;
%      while(j<=clusternum(i)) 
%         stu1 = find(labelSFL == i); 
%         j = j+1;
%      end
%      if(i==1)
%         cluster1 = data(:,stu1);
%         for k=1:20
%             r1(k,1) = length(find(cluster1(k,:)==1));
%             rate1(k,1) = r1(k)/clusternum(i);
%         end
%         cluster11 = find(rate1>=0.9);
%      else
%          if(i==2)
%              cluster2 = data(:,stu1);
%              for k=1:20
%                 r2(k,1) = length(find(cluster2(k,:)==1));
%                 rate2(k,1) = r2(k)/clusternum(i);
%              end
%              cluster22 = find(rate2>=0.9);
%          else
%              if(i==3)
%                 cluster3 = data(:,stu1);
%                 for k=1:20
%                      r3(k,1) = length(find(cluster3(k,:)==1));
%                     rate3(k,1) = r3(k)/clusternum(i);
%                 end
%                 cluster33 = find(rate3>=0.9);
%              else
%                  if(i==4)
%                     cluster4 = data(:,stu1);
%                     for k=1:20
%                         r4(k,1) = length(find(cluster4(k,:)==1));
%                         rate4(k,1) = r4(k)/clusternum(i);
%                     end
%                     cluster44 = find(rate4>=0.9); 
%                  else
% %                      if(i==5)
%                          cluster5 = data(:,stu1);
%                          for k=1:20
%                              r5(k,1) = length(find(cluster5(k,:)==1));
%                             rate5(k,1) = r5(k)/clusternum(i);
%                          end
%                          cluster55 = find(rate5>=0.9);
%                  end
%              end
%          end
%      end
%      
% %                      else
% %                          if(i==6)
% %                             cluster6 = data(:,stu1);
% %                             for k=1:20
% %                                  r6(k,1) = length(find(cluster6(k,:)==1));
% %                                  rate6(k,1) = r6(k)/clusternum(i);
% %                             end
% %                             cluster66 = find(rate6>=0.9);
% %                          else
% %                               cluster7 = data(:,stu1);
% %                               for k=1:20
% %                                   r7(k,1) = length(find(cluster7(k,:)==1));
% %                                   rate7(k,1) = r7(k)/clusternum(i);
% %                               end
% %                               cluster77 = find(rate7>=0.9);
%                 
%                  
%  end
% x = [1,5];
% y = [1,5];
% sim = [49,0,1,1,1;0,232,0,0,0;1,0,76,2,6;1,0,2,90,5;1,0,6,5,89];
% imagesc(sim);
% colorbar;
% colorbar('Direction','reverse');
% colormap(parula(5));

% for i =1 : nClass
%      sums(i) = length(find(labelSFL == i));
%      temp3(i) = abs(sumD_SFL(i))/sums(i);
%  end
%  nStu = max(sums);
%  CP3 = sum(temp3)/nClass; 
% [DVI] = clustering(nClass, nStu ,labelSFL, X_SFL_new);
% disp(['when use SFL to cluster, the sumCP : ' , num2str(CP3)]);
% disp(['when use SFL to cluster, the DVI : ' , num2str(DVI)]);