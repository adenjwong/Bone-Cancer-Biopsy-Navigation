function [rm, hrm] = Rotation_about_Frame_Axis(axis, angle)
% Rotation_about_Frame_Axis rotates a point about one of the (x,y,z) frame
% axes by a given rotation angle
%
% Depending on the inputted axis there are three different rotation
% matrices that are used. The angle is simply plugged into the matrices and
% the resulting rotation matrix is returned.
%
% INPUTS: 
%         axis - One of the (x,y,z) frame axes we are rotating about
%         inputted as a string
%         angle - angle by which we are rotating a point
% OUTPUTS:
%         rm - 3x3 rotation matrix
%         hrm - 4x4 homogenous rotation matrix

if axis == "x" || axis == "X"
    rm = [1 0 0; 0 cosd(angle) -sind(angle); 0 sind(angle) cosd(angle)];
    hrm = [1 0 0 0; 0 cosd(angle) -sind(angle) 0; 0 sind(angle) cosd(angle) 0; 0 0 0 1];
elseif axis == "y" || axis == "Y"
    rm = [cosd(angle) 0 sind(angle); 0 1 0; -sind(angle) 0 cosd(angle)];
    hrm = [cosd(angle) 0 sind(angle) 0; 0 1 0 0; -sind(angle) 0 cosd(angle) 0; 0 0 0 1];
elseif axis == "z" || axis == "Z"
    rm = [cosd(angle) -sind(angle) 0; sind(angle) cosd(angle) 0; 0 0 1];
    hrm = [cosd(angle) -sind(angle) 0 0; sind(angle) cosd(angle) 0 0; 0 0 1 0; 0 0 0 1];
end
end