function [Attrack, Bttrack, Cttrack] = AxisCalibrationtesting()
%row vector
%example output format:
%[rotation1 x, rotation1 y, rotation1 z; rotation2 x, rotation2 y, rotation2 z; ...]

% AxisCalibrationtesting creates 20 different random poses (rotations in
% the y axis of the tool) for the use of calibrating the tool axis.
%
% INPUTS: 
%         NONE
% OUTPUTS:
%         Attrack - matrix of poses of A marker on the tool outputted in the
%         format outlined above
%         Bttrack - matrix of poses of B marker on the tool outputted in the
%         format outlined above
%         Cttrack - matrix of poses of C marker on the tool outputted in the
%         format outlined above

%initialize tool markers in tracker frame
Attracko = [-2 -2 0] + [0 20 0];
Bttracko = [4 -2 0] + [0 20 0];
Cttracko = [-2 4 0] + [0 20 0];

%initialize temporary variables to hold poses
tempAtotal = [];
tempBtotal = [];
tempCtotal = [];

%generate 20 random poses
a = Attracko';
b = Bttracko';
c = Cttracko';

n = 0;
m = 18;
for i = 1:20
    [rm, ~] = Rotation_about_Frame_Axis("y", randi([n,m]));
    a = rm*a;
    b = rm*b;
    c = rm*c;
    
    tempAtotal = [tempAtotal; a'];
    tempBtotal = [tempBtotal; b'];
    tempCtotal = [tempCtotal; c'];

    n = n + 18;
    m = m + 18;

end

%set function return
Attrack = tempAtotal;
Bttrack = tempBtotal;
Cttrack = tempCtotal;

end