function [e, eBuff]=PerceptronTst(x,y,w,b)
% perceptron performance test over (x,y)
tic

[l,~]=size(x);
e=0; % number of test errors
eBuff = zeros(l, 1);
for i = 1:l          
    ey = x(i,:) * w + b; % apply the perceptron classification rule
    if ey >= 0.5 
       ey = 1;
    else
       ey = 0;
    end
    if y(i) ~= ey;
       e = e + 1; 
    end;
    eBuff(i) = e / i;
end

toc