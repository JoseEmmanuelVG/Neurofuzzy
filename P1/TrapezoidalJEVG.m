function [trap,X] = Trapezoidal(start,finish,step,a,b,c,d)
    X=start:step:finish;
    trap=zeros(1,length(X));
    for i=1:length(X)
        if ((X(i)>a && X(i)<=b) && a~=b)
            trap(i)=(X(i)-a)/(b-a);
        elseif ((X(i)>=b && X(i)<=c)) 
            trap(i)=1;
        elseif (X(i)>c && X(i)<=d)
            trap(i)=(d-X(i))/(d-c);
        end
    end
end