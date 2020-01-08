clear 
close all
%% load data
data = xlsread('FrcSub.xlsx');
nClass = 8;
%% Original Data
[labelOriginal,~,sumD_O,~] = kmeans(data,nClass);
for i =1 : nClass
     clusternum(i) = length(find(labelOriginal == i));
     j =1;
     while(j<=clusternum(i)) 
        stu1 = find(labelOriginal == i); 
        j = j+1;
     end
     if(i==1)
        cluster1 = data(stu1,:);
        for k=1:20
            r1(k,1) = length(find(cluster1(:,k)==1));
            rate1(k,1) = r1(k)/clusternum(i);
        end
        cluster11 = find(rate1>=0.9);
     else
         if(i==2)
             cluster2 = data(stu1,:);
             for k=1:20
                r2(k,1) = length(find(cluster2(:,k)==1));
                rate2(k,1) = r2(k)/clusternum(i);
             end
             cluster22 = find(rate2>=0.9);
         else
             if(i==3)
                cluster3 = data(stu1,:);
                for k=1:20
                     r3(k,1) = length(find(cluster3(:,k)==1));
                    rate3(k,1) = r3(k)/clusternum(i);
                end
                cluster33 = find(rate3>=0.9);
             else
                 if(i==4)
                    cluster4 = data(stu1,:);
                    for k=1:20
                        r4(k,1) = length(find(cluster4(:,k)==1));
                        rate4(k,1) = r4(k)/clusternum(i);
                    end
                    cluster44 = find(rate4>=0.9); 
                 else
                     if(i==5)
                         cluster5 = data(stu1,:);
                         for k=1:20
                             r5(k,1) = length(find(cluster5(:,k)==1));
                            rate5(k,1) = r5(k)/clusternum(i);
                         end
                         cluster55 = find(rate5>=0.9);
                     else
                         if(i==6)
                             cluster6 = data(stu1,:);
                             for k=1:20
                                r6(k,1) = length(find(cluster6(:,k)==1));
                                 rate6(k,1) = r6(k)/clusternum(i);
                             end
                             cluster66 = find(rate6>=0.9);
                         else
                             if(i==7)
                                 cluster7 = data(stu1,:);
                                 for k=1:20
                                     r7(k,1) = length(find(cluster7(:,k)==1));
                                     rate7(k,1) = r7(k)/clusternum(i);
                                 end
                                 cluster77 = find(rate7>=0.9);
                             else
                                 cluster8 = data(stu1,:);
                                     for k=1:20
                                         r8(k,1) = length(find(cluster8(:,k)==1));
                                         rate8(k,1) = r8(k)/clusternum(i);
                                     end
                                   cluster88 = find(rate8>=0.9);
                             end
                         end
                     end
                 end
             end
         end
     end
end