function [w,b,eBuff]=PerceptronTrn(x,y)
% perceptron Training
    tic
    % config init
        % l->No.samples | p-> No.features | (w)eight | (b)ias |
        % ier-> indicatorError
        % n -> learningRate
    [l,p]=size(x);  
    w=zeros(p,1);
    b=0;          
    ier=1;       
    pass=0;     
    n=0.5;       

    eBuff = zeros(l,1);

    while ier==1, %repeat until no error
           ier = 0; 
           e = 0; % accumulating training errors
           for i = 1:l  
               ey = x(i,:)* w + b; % estimated y
               if ey >= 0.5
                  ey = 1;
               else
                  ey = 0;
               end
               er = y(i) - ey; % diff between real & predicted
               if er ~= 0
                  e = e + 1;
                  w = w' + (er * n) * x(i,:); % update the direction vector
                  w = w'; 
                  b = b + er;                      
               end;
               eBuff(i) = e / i; % average error (rspct to No.smpls)
           end;  
           if e > 0  % continue if there is still errors
              ier = 1;           
           end
           pass = pass + 1; % stop after 200 iterations
           if pass == 20
              ier = 0;
           end;
     end;

    disp(['Training_Errors=' num2str(e / l) '     Training data Size=' num2str(l)])
    disp(['--- Training Finished ---'])
    toc