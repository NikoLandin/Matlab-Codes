function [L,U,P] = luFactor(A)
%luFactor takes a 3 by 3 coeffiecient matrix A and performs LU factorization with
%partial pivoting to output L, U, and P
%   Inputs:
%   A = coefficient matrix
%   Outputs:
%   L = lower triangular matrix
%   U = upper triangular matrix
%   P = the pivot matrix

%Determines whether the input matrix A is a 3 by 3 matrix
if length(A(1,:)) ~= length(A(:,1))
    error('The matrix A is not a square matrix')
end

%Performs partial pivoting on the first A matrix and defines an initial P matrix
if abs(A(3,1)) > abs(A(1,1))
    P=[0 0 1;0 1 0;1 0 0];
elseif abs(A(2,1)) > abs(A(1,1))
    P=[0 1 0;1 0 0;0 0 1];
else
    P=[1 0 0;0 1 0;0 0 1];
end
A=P*A;
%Pre-defining L and U
L=[1 0 0;0 1 0;0 0 1];
U=A;
%Eliminating A(2,1) and A(3,1)
Ex1=A(2,1)/A(1,1);
Ex2=A(3,1)/A(1,1);
U(2,:)=A(2,:)-Ex1*A(1,:);
U(3,:)=A(3,:)-Ex2*A(1,:);
%Pivoting the new A' matrix (U) and defining a second P matrix
if abs(U(3,2)) > abs(U(2,2))
    P2=[1 0 0;0 0 1;0 1 0];
    ifpivot=1;
else
    ifpivot=0;
    P2=[1 0 0;0 1 0;0 0 1];
end
U=P2*U;
%Eliminating U(3,2)
Ex3=U(3,2)/U(2,2);
U(3,:)=U(3,:)-Ex3*U(2,:);
%Creating the L matrix
if ifpivot==1
    L(2,1)=Ex2;
    L(3,1)=Ex1;
else
    L(2,1)=Ex1;
    L(3,1)=Ex2;
end
L(3,2)=Ex3;
%Creating the final P matrix
P=P2*P;
%Presenting outputs
L
U
P
end

