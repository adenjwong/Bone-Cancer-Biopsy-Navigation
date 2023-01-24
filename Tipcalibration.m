function TIPtool = Tipcalibration(Attrack, Bttrack, Cttrack)
%row vector
%example input format:
%[pose1 x, pose1 y, pose1 z; pose2 x, pose2 y, pose2 z; ...]

% Tipcalibration takes three matrices each describing the surigical tool in
% different poses in 3D space and returns the position of the tool tip
%
% INPUTS: 
%         Attrack - matrix of poses of A marker on the tool inputted in the
%         format outlined above
%         Bttrack - matrix of poses of B marker on the tool inputted in the
%         format outlined above
%         Cttrack - matrix of poses of C marker on the tool inputted in the
%         format outlined above
% OUTPUTS:
%         TIPtool - Position of the tool tip in tool frame

%fit all 3 each point onto a sphere and find centre
[c1, ~] = sphereFit(Attrack);
[c2, ~] = sphereFit(Bttrack);
[c3, ~] = sphereFit(Cttrack);

%calculate the average of the centres and round to 1 decimal places (1 mm)
avgx = (c1(1)+c2(1)+c3(1))/3;
avgy = (c1(2)+c2(2)+c3(2))/3;
avgz = (c1(3)+c2(3)+c3(3))/3;

TIPtoolTframe = [avgx avgy avgz];
TIPtoolTframe = round(TIPtoolTframe, 1);

%find the average of the tool tip in all poses of tool frame
TIPtotal = [0 0 0];
for i = 1:size(Attrack,1)
[Oe, e1, e2, e3] = Generate_Orthogonal_Frame(Attrack(i,:), Bttrack(i,:), Cttrack(i,:));
t = inv(Frame_Transformation_to_Home(Oe, e1, e2, e3));
TIPtoolTframe = [TIPtoolTframe 1];
TIPtemp = t*TIPtoolTframe';
TIPtoolTframe(end) = [];
TIPtemp = TIPtemp';
TIPtemp(end) = [];
TIPtotal = TIPtotal + TIPtemp;
end
TIPtool = TIPtotal./size(Attrack,1);
TIPtool = round(TIPtool,1);

end