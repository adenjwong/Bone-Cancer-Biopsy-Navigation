function [Oe, e1, e2, e3] = Generate_Orthogonal_Frame(A, B, C)
% Generate_Orthogonal_Frame computes an orthogonal frame from three points
% and defines the center of the frame as the center of gravity
%
% The function returns the centre of gravity by averaging out all three
% points that are inputted. The base vectors are then generated using the
% cross product of the vectors created from the inputted data and
% the the cross product from the vector and its cross product.
%
% INPUTS: 
%         A - one point
%         B - one point
%         C - one point
% OUTPUTS:
%         Oe - center of gravity and the generated orthogonal frame
%         e1 - base vector
%         e2 - base vector
%         e3 - base vector

avgx = (A(1)+B(1)+C(1))/3;
avgy = (A(2)+B(2)+C(2))/3;
avgz = (A(3)+B(3)+C(3))/3;

Oe = [avgx; avgy; avgz] - [0;0;0];

d = C-A;
e1 = B-A;
e3 = cross(e1, d);
e2 = cross(e3, e1);

if cross(A,B) == 0 | cross(A,C) == 0 | cross(B,C) == 0
    disp('Inputted coordinates exist collinearly')
    Oe = nan;
    e1 = nan;
    e2 = nan;
    e3 = nan;
else
    e1 = e1 / norm(e1);
    e2 = e2 / norm(e2);
    e3 = e3 / norm(e3);
end

end