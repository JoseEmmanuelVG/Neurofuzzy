%Sigmoid Function
function [sigm,X] = Sigmoid(start,finish,step,a,c)
    X=start:step:finish;
    sigm=1./(1+exp(-a*(X-c)));
end
