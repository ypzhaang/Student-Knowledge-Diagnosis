clear
close all
data = xlsread('StudentReponses1.xlsx');
[row,col] = size(data);
[m,n] = find(isnan(data));
data(m,:) = [];
datause =data;
data = datause';
grade = data(1,:);
data(1,:) = [];
nClass = 4;
%% compareable experiment sparfa
dataSparfa = load('sparfaCSecond.txt');
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
        for k = 1:25
            r1(k,1) = length(find(cluster1(k,:)==1));
             w1(k,1) = length(find(cluster1(k,:)==0));
            rate1(k,1) = r1(k)/clusternum(i); 
             wrong1(k,1) = w1(k)/clusternum(i);
        end
        cluster11r = find(rate1>=0.9);
         cluster11w = find(wrong1>=0.9);
            res1 = (length(cluster11r)+length( cluster11w))/20;
    else
        if(i==2)
            cluster2 = data(:,stu);
        for k = 1:25
            r2(k,1) = length(find(cluster2(k,:)==1));
            w2(k,1) = length(find(cluster2(k,:)==0));
            rate2(k,1) = r2(k)/clusternum(i);   
             wrong2(k,1) = w2(k)/clusternum(i);
        end
            cluster22r = find(rate2>=0.9);
            cluster22w = find(wrong2>=0.9);
             res2 = (length(cluster22r)+length( cluster22w))/20;
        else
            if(i==3)
                 cluster3 = data(:,stu);
            for k = 1:25
                 r3(k,1) = length(find(cluster3(k,:)==1));
                   w3(k,1) = length(find(cluster3(k,:)==0));
                 rate3(k,1) = r3(k)/clusternum(i); 
                     wrong3(k,1) = w3(k)/clusternum(i);
            end
             cluster33r = find(rate3>=0.9);
              cluster33w = find(wrong3>=0.9);
              res3 = (length(cluster33r)+length( cluster33w))/20;
            else
                cluster4 = data(:,stu);
                for k = 1:25
                    r4(k,1) = length(find(cluster4(k,:)==1));
                     w4(k,1) = length(find(cluster4(k,:)==0));
                    rate4(k,1) = r4(k)/clusternum(i);  
                    wrong4(k,1) = w4(k)/clusternum(i);
                end
                 cluster44r = find(rate4>=0.9);
                  cluster44w = find(wrong4>=0.9);
                res4 = (length(cluster44r)+length( cluster44w))/20;
            end
        end
    end   
end

%% figure
% x = 1:1:20;
% h = bar(x,[rate1 rate2 rate3 rate4]);
% legend('cluster1','cluster2','cluster3','cluster4');
% boxplot([rate1 rate2 rate3 rate4],{'cluster1','cluster2','cluster3','cluster4'});
% title('Using SPARFA Method')
% xlabel('Each Cluster')
% ylabel('Correct Answer for Each Question(%)')
y = [0.6,0.6,0.6,0.72;0.32,0.4,0.6,0.7;0,0.48,0.52,0.6;0.36,0.52,0.52,0.6];
 bar(y,0.5,'grouped')
set(gca,'Xticklabel',{'MetaDL','SPARFA','Original','BOBCS'});
ylabel('Consistency Degree (CD) ')