function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
%This function determines the root of a given function using the false
%position approximation technique given a lower and upper guess
%   Inputs:
% func = function being evaluated
% xl = lower guess
% xu = upper guess
% es = desired relative error (defaults to .0001%)
% maxiter = number of iterations desired (defaults to 200)

%stores the given func as f for ease of evaluation
syms x;
f=symfun(func,x);
%determines whether there is enough inputs and sets defaults
if nargin<5 
    maxiter=200;
end
if nargin<4
    es=.0001;
    maxiter=200;
end
if nargin<3
    error('code requires at least func, xl, and xu')
end
    
        
%determines whether there is a root between the two given estimates
if f(xl)*f(xu)<0
    fxl=f(xl);
    fxu=f(xu);
else
    error('there is no root between the two estimates')
end
%calculates the first root approximation
root=xl-(((xu-xl)*(fxl))/(fxu-fxl));
%sets new estimates for the interval
if f(root)*fxl<0
    xu=root;
else
    xl=root;
end
%sets values to use in the error approximation and stores the previous root
%creates a variable to track how many iterations have past
pr=root;
ea=1;
iteration=1;
%calculates a new root approximation until either the maxiter is met or the
%error approximation falls below desired value
while iteration<maxiter && ea>=es
    root=xl-((xu-xl)*(fxl)/(fxu-fxl));
    if f(root)*fxl<0
        xu=root;
    else
        xl=root;
    end
    ea=abs(((root-pr)/root)*100);
    iteration=iteration+1;
    pr=root;
end
%displays results in a nice format
root=double(root)
iter=iteration
ea=double(ea)

end

