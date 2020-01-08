clc
clear
close all
%% compareable experiment(original data)
%data = xlsread('FrcSub.xlsx');
data = xlsread('StudentReponses1.xlsx');
[row,col] = size(data);
[m,n] = find(isnan(data));
data(m,:) = [];
datause =data;
data = datause';
grade = data(1,:);
data(1,:) = [];
nClass = 4;
%data = data';
[X_BIHT,S] = BIHT(data);
[labelBIHT,~,sumD_B,~] = kmeans(S',nClass);
for i = 1:nClass
    clusternum(i) = length(find(labelBIHT==i));
    j = 1;
    while(j<=clusternum(i))
        stu = find(labelBIHT==i);
        j = j+1;
    end
    if(i==1)
        cluster1 = data(:,stu);
        for k = 1:25
            r1(k,1) = length(find(cluster1(k,:)==1));
             w1(k,1) = length(find(cluster1(k,:)==0));
            rate1(k,1) = r1(k)/clusternum(i); 
             wrong1(k,1) = w1(k)/clusternum(i);
        end
        cluster11r = find(rate1>=0.8);
         cluster11w = find(wrong1>=0.8);
    else
        if(i==2)
            cluster2 = data(:,stu);
        for k = 1:25
            r2(k,1) = length(find(cluster2(k,:)==1));
            w2(k,1) = length(find(cluster2(k,:)==0));
            rate2(k,1) = r2(k)/clusternum(i);   
             wrong2(k,1) = w2(k)/clusternum(i);
        end
            cluster22r = find(rate2>=0.8);
            cluster22w = find(wrong2>=0.8);
        else
            if(i==3)
                 cluster3 = data(:,stu);
            for k = 1:25
                 r3(k,1) = length(find(cluster3(k,:)==1));
                   w3(k,1) = length(find(cluster3(k,:)==0));
                 rate3(k,1) = r3(k)/clusternum(i); 
                     wrong3(k,1) = w3(k)/clusternum(i);
            end
             cluster33r = find(rate3>=0.8);
              cluster33w = find(wrong3>=0.8);
            else
                cluster4 = data(:,stu);
                for k = 1:25
                    r4(k,1) = length(find(cluster4(k,:)==1));
                     w4(k,1) = length(find(cluster4(k,:)==0));
                    rate4(k,1) = r4(k)/clusternum(i);  
                    wrong4(k,1) = w4(k)/clusternum(i);
                end
                 cluster44r = find(rate4>=0.8);
                  cluster44w = find(wrong4>=0.8);
                
            end
        end
    end   
end