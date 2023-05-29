%Bell Function
function [bell,X] = Bell(start,finish,step,a,b,c)
    X=start:step:finish;
    bell=1./(1+(abs((X-c)./a)).^(2*b));
end

