% Gaussian function
function [gauss,X] = Gaussian(start,finish,step,c,sigma)
    X=start:step:finish;
    gauss=exp((-1/2)*(((X-c)/sigma).^2));
end
