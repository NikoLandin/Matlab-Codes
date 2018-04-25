# Heuns method  
This code uses Heuns method to find a solution to a differential equation given the  
## Inputs  

**dydt** the differential function  

**tspan** the interval the solution will cover  

**y0** the initial condition  

**h** the desired step size  

**es** the stopping criterion for iterating the corrector  

**maxit** maximum iterations desired  

and  
## Outputs  

**t** set of t values  

**y** set of y values  

This code requires at least dydt tspan y0 and h, if es and maxit are not input they will default to .001 and 50 automatically  
If the user inputs a tspan and an h that arent compatible ie. 0 to 2.1 and a step size of .2, then the algorithm will correct the final step size to fit that interval.
