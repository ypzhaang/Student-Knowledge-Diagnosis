function [error, label, iter] = jackmeans(data, k)
%% data size
[m,n] = size(data);
centroids = zeros(k,n);
dis = zeros(m,k);
dis1 = zeros(m,k);
label= zeros(m,1);
itermax = 5;

%% initial center
for i = 1:n
    ma(i) = max(data(:,i));
    mi(i) = min(data(:,1));
    for j =1:k
        centroids(j,i) = ma(i)+(mi(i)-max(i))*rand();
    end
end
%% iteration
for iter =1:itermax
for i=1:m
    for j=1:k
         dis1(i,j)=Jacard(data(i,:),centroids(j,:));
    end
end

for i=1:m
    [dissort,index]=sort(dis1(i,:));
     label(i,1)=index(1,1);
end
sumaver = zeros(k,n);
number = zeros(k,1);

 for i=1:m
     sumaver(label(i,1),:) = sumaver(label(i,1),:)+data(i,:);
     number(label(i,1),1) = number(label(i,1),1)+1;
 end
for k=1:k
    sumaver(k,:) = sumaver(k,:)./number(k,1);
    centroids(k,:) = sumaver(k,:);
end
error=0;
for i=1:m
for k=1:k
error = error+sum((dis1(i,k)-dis(i,k)).^2);
end
end
dis = dis1;
dis1 = zeros(m,k);
if error==0
   break;
end

end