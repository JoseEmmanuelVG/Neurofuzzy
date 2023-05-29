function[x,trap]=trapezoidal(start,en,step,a,b,c,d)
    x=start:step:en;
    n=length(x);
    for i=1:n
        if(x(i)<=a)
            trap(i)=0;
            if a==b
                trap(i)=1;
            end
        elseif(x(i)>a && x(i)<=b)
            trap(i)=(x(i)-a)/(b-a);
        elseif(x(i)>b && x(i)<=c)
            trap(i)=1;
        elseif(x(i)>c && x(i)<=d)
            trap(i)=(d-x(i))/(d-c);
        elseif(x(i)>d)
            trap(i)=0;
        end
    end
    %plot(x,trap)
end