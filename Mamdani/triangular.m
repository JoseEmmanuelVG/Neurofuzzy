function[x,trian]=triangular(start,en,step,a,b,c)
    x=start:step:en;
    n=length(x);
    for i=1:n
        if(x(i)<=a)
            trian(i)=0;
            if a==b
                trian(i)=1;
            end
        end
        if(x(i)>a & x(i)<=b)
            trian(i)=(x(i)-a)/(b-a);
        end
        if(x(i)>b & x(i)<=c)
            trian(i)=(c-x(i))/(c-b);
        end
        if(x(i)>c)
            trian(i)=0;
        end
    end
    %plot(x,trian)
end