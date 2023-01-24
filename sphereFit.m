function [Center,Radius] = sphereFit(X)
% this fits a sphere to a collection of data using a closed form for the
% solution (opposed to using an array the size of the data set). 
% Minimizes Sum((x-xc)^2+(y-yc)^2+(z-zc)^2-r^2)^2
% x,y,z are the data, xc,yc,zc are the sphere's center, and r is the radius
% Assumes that points are not in a singular configuration, real numbers, ...
% if you have coplanar data, use a circle fit with svd for determining the
% plane, recommended Circle Fit (Pratt method), by Nikolai Chernov
% http://www.mathworks.com/matlabcentral/fileexchange/22643
% Input:
% X: n x 3 matrix of cartesian data
% Outputs:
% Center: Center of sphere 
% Radius: Radius of sphere
% Author:
% Alan Jennings, University of Dayton
A=[mean(X(:,1).*(X(:,1)-mean(X(:,1)))), ...
    2*mean(X(:,1).*(X(:,2)-mean(X(:,2)))), ...
    2*mean(X(:,1).*(X(:,3)-mean(X(:,3)))); ...
    0, ...
    mean(X(:,2).*(X(:,2)-mean(X(:,2)))), ...
    2*mean(X(:,2).*(X(:,3)-mean(X(:,3)))); ...
    0, ...
    0, ...
    mean(X(:,3).*(X(:,3)-mean(X(:,3))))];
A=A+A.';
B=[mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,1)-mean(X(:,1))));...
    mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,2)-mean(X(:,2))));...
    mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,3)-mean(X(:,3))))];
Center=(A\B).';
Radius=sqrt(mean(sum([X(:,1)-Center(1),X(:,2)-Center(2),X(:,3)-Center(3)].^2,2)));

%code used from https://www.mathworks.com/matlabcentral/fileexchange/34129-sphere-fit-least-squared
end

function v = Generate_Random_Unit_Vector(num)
% Generate_Random_Unit_Vector generates a random unit vector in a random
% direction in 2D or 3D
%
% The function only accepts an input of either 2 or 3 and creates a random
% vector of the size 1 x input. In order to generate a random vector we 
% use randn(n,m) which returns a matrix of the size n x m. The vector is 
% then normalized by dividing its by its norm.
%
% INPUTS: 
%         num - 2 or 3 to specify dimension
% OUTPUTS:
%         v - random vector in either 2D or 3D

if num < 2 || num > 3
    disp('Not a valid input')
end

if num == 2
    t = randn(1,2);
    v = t / norm(t);
end

if num == 3
    t = randn(1,3);
    v = t / norm(t);
end
end