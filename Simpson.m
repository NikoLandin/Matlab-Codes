function [I] = Simpson(x,y)
%This function takes a given set of data and computes an approximation the 
%integral of said data using simpsons 1/3 rule, if the data has an odd 
%number of intervals then the trapezoidal rule will be used for the last 
%interval 
%   Inputs:
%   x = vector containing the x values of the data
%   y = vector containing the y values of the data
%   Outputs:
%   I = the integral approximation of the data 

%Creates a variable lx which contains the length of x so that the code
%looks better and is faster
lx=length(x);
%This section checks if x and y have the same length
if lx ~= length(y)
    error('x and y must be the same length')
end
%This section checks if x is equally spaced
spacex=diff(x);
eq=all(spacex == spacex(1));
if eq == 0
    error('x vector must be equally spaced')
end
%Warns the user if the trapezoidal rule must be used
one3=1;
if rem((lx-1),2) ~= 0
    warning('The trapezoidal rule will be used of the last interval')
    one3=0;
end
%This section computes the integral approximation of the data
I=0;
if one3 == 1
    for i=3:2:lx
        I = I + [x(i)-x(i-2)]*(y(i-2)+4*y(i-1)+y(i))/6;
    end
elseif one3 == 0
    for i=3:2:(lx-1)
        I = I + [x(i)-x(i-2)]*(y(i-2)+4*y(i-1)+y(i))/6;
    end
    I = I + [x(lx)-x(lx-1)]*(y(lx)+y(lx-1))/2;
end
end

