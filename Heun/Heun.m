function [t,y] = Heun(dydt,tspan,y0,h,es,maxit)
%This function utilizes Heuns method to find a solution to a differential
%equation given and initial condition, step size, and stopping criterion
%for the predictor-corrector (es and maxit). es and maxit are optional and
%will be defaulted to .001 and 50 respectively if there are not input.
%   Inputs:
%   dydt = differential equation as an anonymous equation
%   tspan = interval we are solving the diff eq
%   y0 = initial condition
%   h = step size
%   es = stopping criterion of the predictor corrector (defaults to .001)
%   maxit = maximum iterations of the predictor corrector (defaults to 50)
%   Outputs:
%   t = set of t values corresponding to y values of the solution
%   y = set of y values of the solution

%This section decides whether es or maxit were input and sets defaults
if nargin < 4
    error("dydt tspan y0 and h are required")
end
if nargin < 5 
    es = .001;
end
if nargin < 6
    maxit = 50;
end
%This section decides whether the user input a tspan and h that fit
%together or if there must be a seperate h for the last predictor corrector
equalspan = tspan/h;
integr = floor(equalspan);
correctedh = 0;
if integr ~= equalspan
    lastint = equalspan - integr;
    hf = lastint(1,2)*h;
    correctedh = 1;
end
%This section uses heuns method to get the t and y vectors
if correctedh == 0 
    t = [tspan(1,1):h:tspan(1,2)];
elseif correctedh == 1
    x2 = h*(integr(1,2)-1)+tspan(1,1)+h; %x2 helps create the t vector if tspan and h are not compatible
    t = [(tspan(1,1):h:x2) (x2+hf)]; 
end
numy = numel(t); %helps when created y vector
y = zeros(1,numy);
y(1,1) = y0;
if correctedh == 0
    for i = 2:1:numy
        y(1,i)=y(1,i-1)+h*dydt(t(1,i-1),y(1,i-1));
        j=0; %used to track how many times the corrector is used
        ea = 100;
        while abs(ea) > abs(es) && j < maxit
            sr=dydt(t(1,i),y(1,i));
            sl=dydt(t(1,i-1),y(1,i-1));
            prev=y(1,i);
            y(1,i)=y(1,i-1)+(h/2)*(sl+sr);
            ea = abs(((y(1,i)-prev)/y(1,i))*100);
            j=j+1;
        end
    end
elseif correctedh == 1
    for i = 2:1:numy-1
        y(1,i)=y(1,i-1)+h*dydt(t(1,i-1),y(1,i-1));
        j=0; %used to track how many times the corrector is used
        ea = 100;
        while abs(ea) > abs(es) && j < maxit
            sr=dydt(t(1,i),y(1,i));
            sl=dydt(t(1,i-1),y(1,i-1));
            prev=y(1,i);
            y(1,i)=y(1,i-1)+(h/2)*(sl+sr);
            ea = abs(((y(1,i)-prev)/y(1,i))*100);
            j=j+1;
        end
    end
    y(1,numy)=y(1,numy-1)+hf*dydt(t(1,numy-1),y(1,numy-1));
    j=0;
    ea=100;
    while abs(ea) > abs(es) && j < maxit
        sr=dydt(t(1,numy),y(1,numy));
        sl=dydt(t(1,numy-1),y(1,numy-1));
        prev=y(1,numy);
        y(1,i)=y(1,i-1)+(hf/2)*(sl+sr);
        ea = abs(((y(1,numy)-prev)/y(1,numy))*100);
        j=j+1;
    end
end
plot(t,y)


end

