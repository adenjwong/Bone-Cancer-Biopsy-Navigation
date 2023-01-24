function [Attrack, Bttrack, Cttrack] = TipCalibrationtesting()
%row vector
%example output format:
%[rotation1 x, rotation1 y, rotation1 z; rotation2 x, rotation2 y, rotation2 z; ...]

% TipCalibration creates 20 different random poses (pivots in the x and z
% axis of the tool) for the use of calibrating the tool tip.
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

%create temporary variable to hold poses
tempAtotal = [];
tempBtotal = [];
tempCtotal = [];

%generate 20 random poses
for i = 1:20
    [rm, ~] = Rotation_about_Frame_Axis("x", randi([-75,75]));
    tempA = rm*Attracko';
    tempB = rm*Bttracko';
    tempC = rm*Cttracko';

    [rm, ~] = Rotation_about_Frame_Axis("z", randi([-75,75]));
    tempA = rm*tempA;
    tempB = rm*tempB;
    tempC = rm*tempC;
    
    tempAtotal = [tempAtotal; tempA'];
    tempBtotal = [tempBtotal; tempB'];
    tempCtotal = [tempCtotal; tempC'];
end

%set function return
Attrack = tempAtotal;
Bttrack = tempBtotal;
Cttrack = tempCtotal;
end