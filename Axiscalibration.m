function AXIStool = Axiscalibration(Attrack, Bttrack, Cttrack)
%row vector
%example input format:
%[rotation1 x, rotation1 y, rotation1 z; rotation2 x, rotation2 y, rotation2 z; ...]

% Axiscalibration takes three matrices each describing the surigical tool in
% different poses in 3D space and returns the direction of the tool axis
%
% INPUTS: 
%         Attrack - matrix of poses of A marker on the tool inputted in the
%         format outlined above
%         Bttrack - matrix of poses of B marker on the tool inputted in the
%         format outlined above
%         Cttrack - matrix of poses of C marker on the tool inputted in the
%         format outlined above
% OUTPUTS:
%         AXIStool - direction of the tool axis in tool frame

%compute centre of circle and normal vector of "circular planes created"
[center1, norm1, ~] = CircFit3D(Attrack);
[center2, norm2, ~] = CircFit3D(Bttrack);
[center3, norm3, ~] = CircFit3D(Cttrack);

if (dot(norm1, norm2) < 0)
    % flip the sign of nB so it matches nA's direction
    norm2 = -norm2;
end
if (dot(norm1, norm3) < 0)
    % flip the sign of nC so it matches nA's direction
    norm3 = -norm3;
end


%find average normal vector
vh = (norm1 + norm2 + norm3)/3;
vh = vh';

%find the average of the tool axis in all poses of tool frame
vmtotal = [0 0 0];
for i = 1:size(Attrack,1)
[Oe, e1, e2, e3] = Generate_Orthogonal_Frame(Attrack(i,:), Bttrack(i,:), Cttrack(i,:));
t = Frame_Transformation_to_Home(Oe, e1, e2, e3)';
vh = [vh 1];
tempv = t'*vh';
vh(end) = [];
tempv = tempv';
tempv(end) = [];
vmtotal = vmtotal + tempv;
end
AXIStool = vmtotal./size(Attrack,1);
AXIStool = AXIStool/norm(AXIStool);

end