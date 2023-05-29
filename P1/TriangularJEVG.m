%Triangular Function
function [trian,X] = Triangular(start,finish,step,a,b,c)
    X=start:step:finish;
    trian=zeros(1,length(X));
    for i=1:length(X)
        if ((X(i)>a && X(i)<=b) && a~=b)
            trian(i)=(X(i)-a)/(b-a);
        elseif X(i)>=b && X(i)<=c
            trian(i)=(c-X(i))/(c-b);
        end
    end
end