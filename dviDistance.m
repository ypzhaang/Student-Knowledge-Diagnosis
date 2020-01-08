function [distance] = dviDistance(numx,numy,data)
%DVIDISTANCE 此处显示有关此函数的摘要
%   numx.numy 保存了属于x,y类的学生的编号
x = length(find(numx ~= 0));
y = length(find(numy ~= 0));
for i = 1 : x
    for j = 1 : y
        stu1 = numx(i) ; stu2 = numy(j);
        if (stu1 ~= 0 && stu2 ~= 0)
            distance(i,j) = norm(data(stu1 , :) - data(stu2 , :));
        end
    end
end

end

