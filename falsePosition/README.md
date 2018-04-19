# False Position

This code utilizes the false position method to find a root of a given function given a lower and upper guess.
Limitations of this code are that the initial guesses must bracket the root, however there is a built in error message if they do not.  
## Inputs
  
**func** the function being evaluated  

**xl** lower guess
  
**xu** upper guess  

**es** desired relative error  

**maxiter** maximum iterations desired
  
## Outputs  
**root** root of the function  
**fx** value of function at root  
**ea** approximate error  
**iter** number of iterations  