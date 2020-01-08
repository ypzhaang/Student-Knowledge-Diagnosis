clear 
close all
%% load data
data = xlsread('FrcSub.xlsx');
data = data';
nClass =4;
%% do SFL
[err, D, X_SFL, W, J] = runDemo(data, 0.03, 0.4, 0.2, 500,50, 1.3 ,30);
%  D_Nor = NormalizeFea(D, 1);
%  D_Nor= (D_Nor < 0.001) .* 0 + (D_Nor>= 0.001).*D_Nor;
 X_SFL_new = X_SFL';
 [labelSFL,~,sumD_SFL,~] = kmeans(X_SFL_new,nClass);
 for i =1 : nClass
     clusternum(i) = length(find(labelSFL == i));
     j =1;
     while(j<=clusternum(i)) 
        stu1 = find(labelSFL == i); 
        j = j+1;
     end
     if(i==1)
        cluster1 = data(:,stu1);
        for k=1:20
            r1(k,1) = length(find(cluster1(k,:)==1));
            w1(k,1) = length(find(cluster1(k,:)==0));
            rate1(k,1) = r1(k)/clusternum(i);
            wrong1(k,1) = w1(k)/clusternum(i);
        end
        cluster11r = find(rate1>=0.8);
        cluster11w = find(wrong1>=0.8);
        res1 = (length(cluster11r)+length( cluster11w))/20;
     else
         if(i==2)
             cluster2 = data(:,stu1);
             for k=1:20
                r2(k,1) = length(find(cluster2(k,:)==1));
                 w2(k,1) = length(find(cluster2(k,:)==0));
                rate2(k,1) = r2(k)/clusternum(i);
                 wrong2(k,1) = w2(k)/clusternum(i);
             end
             cluster22r = find(rate2>=0.8);
             cluster22w = find(wrong2>=0.8);
               res2 = (length(cluster22r)+length( cluster22w))/20;
         else
             if(i==3)
                cluster3 = data(:,stu1);
                for k=1:20
                     r3(k,1) = length(find(cluster3(k,:)==1));
                     w3(k,1) = length(find(cluster3(k,:)==0));
                    rate3(k,1) = r3(k)/clusternum(i);
                    wrong3(k,1) = w3(k)/clusternum(i);
                end
                cluster33r = find(rate3>=0.8);
                cluster33w = find(wrong3>=0.8);
                  res3 = (length(cluster33r)+length( cluster33w))/20;
             else
                    cluster4 = data(:,stu1);
                    for k=1:20
                        r4(k,1) = length(find(cluster4(k,:)==1));
                         w4(k,1) = length(find(cluster4(k,:)==0));
                        rate4(k,1) = r4(k)/clusternum(i);
                         wrong4(k,1) = w4(k)/clusternum(i);
                    end
                    cluster44r = find(rate4>=0.8); 
                     cluster44w= find(wrong4>=0.8);
                       res4 = (length(cluster44r)+length( cluster44w))/20;
                
             end
         end
     end
end          

 %% figure SFL
 y = [0.4 0.6 0.9 0.95;0.05 0.1 0.4 0.9;0.4 0.45 0.75 0.85;0.05,0.2,0.65,0.65];
 bar(y,0.5,'grouped')
set(gca,'Xticklabel',{'MetaDL','SPARFA','Original','BOBCS'});
ylabel('Consistency Degree (CD) ')