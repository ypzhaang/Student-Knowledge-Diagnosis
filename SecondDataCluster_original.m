clear
close all
%% compareable experiment(original data)
data = xlsread('StudentReponses1.xlsx');
[row,col] = size(data);
[m,n] = find(isnan(data));
data(m,:) = [];
datause =data;
data = datause';
grade = data(1,:);
data(1,:) = [];
nClass = 4;
[label,~,sumD,~] = kmeans(data' ,nClass);
for i = 1:nClass
    clusternum(i) = length(find(label==i));
    j = 1;
    while(j<=clusternum(i))
        stu = find(label==i);
        j = j+1;
    end
    if(i==1)
        cluster1 = data(:,stu);
        for k = 1:20
            r1(k,1) = length(find(cluster1(k,:)==1));
             w1(k,1) = length(find(cluster1(k,:)==0));
            rate1(k,1) = r1(k)/clusternum(i); 
             wrong1(k,1) = w1(k)/clusternum(i);
        end
        cluster11r = find(rate1>=0.9);
         cluster11w = find(wrong1>=0.9);
    else
        if(i==2)
            cluster2 = data(:,stu);
        for k = 1:20
            r2(k,1) = length(find(cluster2(k,:)==1));
            w2(k,1) = length(find(cluster2(k,:)==0));
            rate2(k,1) = r2(k)/clusternum(i);   
             wrong2(k,1) = w2(k)/clusternum(i);
        end
            cluster22r = find(rate2>=0.9);
            cluster22w = find(wrong2>=0.9);
        else
            if(i==3)
                 cluster3 = data(:,stu);
            for k = 1:20
                 r3(k,1) = length(find(cluster3(k,:)==1));
                   w3(k,1) = length(find(cluster3(k,:)==0));
                 rate3(k,1) = r3(k)/clusternum(i); 
                     wrong3(k,1) = w3(k)/clusternum(i);
            end
             cluster33r = find(rate3>=0.9);
              cluster33w = find(wrong3>=0.9);
            else
                cluster4 = data(:,stu);
                for k = 1:20
                    r4(k,1) = length(find(cluster4(k,:)==1));
                     w4(k,1) = length(find(cluster4(k,:)==0));
                    rate4(k,1) = r4(k)/clusternum(i);  
                    wrong4(k,1) = w4(k)/clusternum(i);
                end
                 cluster44r = find(rate4>=0.9);
                  cluster44w = find(wrong4>=0.9);
                
            end
        end
    end   
end
ave1 = mean(rate1);
ave2 = mean(rate2);
ave3 = mean(rate3);
ave4 = mean(rate4);
ave = [ave1;ave2;ave3;ave4];
%% figure
boxplot([rate1 rate2 rate3 rate4],{'cluster1','cluster2','cluster3','cluster4'});
title('Using Original Data')
xlabel('Each cluster')
ylabel('Correct Answer for Each Question(%)')
