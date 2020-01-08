clear
close all
%% compareable experiment
data = xlsread('FrcSub.xlsx');
data = data';
nClass = 4;
%% sparfa
dataSparfa = load('sparfaCFrcSub.txt');
dataSparfa  = dataSparfa';
[labelSparfa,~,sumD_Spa,~] = kmeans(dataSparfa ,nClass);
for i = 1:nClass
    clusternum(i) = length(find(labelSparfa==i));
    j = 1;
    while(j<=clusternum(i))
        stu = find(labelSparfa==i);
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
        cluster11r = find(rate1>=0.8);
         cluster11w = find(wrong1>=0.8);
         res1 = (length(cluster11r)+length( cluster11w))/20;
    else
        if(i==2)
            cluster2 = data(:,stu);
        for k = 1:20
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
                 cluster3 = data(:,stu);
            for k = 1:20
                 r3(k,1) = length(find(cluster3(k,:)==1));
                   w3(k,1) = length(find(cluster3(k,:)==0));
                 rate3(k,1) = r3(k)/clusternum(i); 
                     wrong3(k,1) = w3(k)/clusternum(i);
            end
             cluster33r = find(rate3>=0.8);
              cluster33w = find(wrong3>=0.8);
               res3 = (length(cluster33r)+length( cluster33w))/20;
            else
                cluster4 = data(:,stu);
                for k = 1:20
                    r4(k,1) = length(find(cluster4(k,:)==1));
                     w4(k,1) = length(find(cluster4(k,:)==0));
                    rate4(k,1) = r4(k)/clusternum(i);  
                    wrong4(k,1) = w4(k)/clusternum(i);
                end
                 cluster44r = find(rate4>=0.8);
                  cluster44w = find(wrong4>=0.8);
                res4 = (length(cluster44r)+length( cluster44w))/20;
            end
        end
    end   
end
