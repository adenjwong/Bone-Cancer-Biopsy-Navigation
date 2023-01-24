%Tip calibration and Tip calibration testing
fprintf('\n');
disp('Tip calibration and Tip calibration testing:\n');
[Attrack, Bttrack, Cttrack] = TipCalibrationtesting();
TIPtool = Tipcalibration(Attrack, Bttrack, Cttrack)

%Axis calibration and Axis calibration testing
fprintf('\n');
disp('Axis calibration and Axis calibration testing:\n');
[Attrack, Bttrack, Cttrack] = AxisCalibrationtesting();
AXIStool = Axiscalibration(Attrack, Bttrack, Cttrack)



%simulation - Error Navigation Analysis
%initialize marker points
Attrack = [-2 -2 0] + [0 20 0];
Bttrack = [4 -2 0] + [0 20 0];
Cttrack = [-2 4 0] + [0 20 0];

Amtrack = [-2 -2 0] + [10 10 0];
Bmtrack = [4 -2 0] + [10 10 0];
Cmtrack = [-2 4 0] + [10 10 0];

%initialize RMSE
RMSE = 0.25;

%initialize markers with gaussian error
Attrackerr = [];
Bttrackerr = [];
Cttrackerr = [];

Amtrackerr = [];
Bmtrackerr = [];
Cmtrackerr = [];

%variable to hold the number of markers
N = 10;

%create markers with gaussian error
for i = 1:N
Attrackerr = [Attrackerr; normrnd(Attrack , RMSE)];
Bttrackerr = [Bttrackerr; normrnd(Bttrack , RMSE)];
Cttrackerr = [Cttrackerr; normrnd(Cttrack , RMSE)];

Amtrackerr = [Amtrackerr; normrnd(Amtrack , RMSE)];
Bmtrackerr = [Bmtrackerr; normrnd(Bmtrack , RMSE)];
Cmtrackerr = [Cmtrackerr; normrnd(Cmtrack , RMSE)];
end

%create error tool tip markers and error axis
tooltiperr = [];
toolaxiserr = [];
for j = 1:N
[~, e1, e2, e3] = Generate_Orthogonal_Frame(Attrackerr(j,:), Bttrackerr(j,:), Cttrackerr(j,:));
t = inv(Frame_Transformation_to_Home([0 0 0], e1, e2, e3));

tooltipttrack = [0 -20 0 1];
temp1 = t*tooltipttrack';
temp1(end) = [];
tooltiperr = [tooltiperr; temp1'];

toolaxisttrack = [0 -1 0 1];
temp2 = t*toolaxisttrack';
temp2(end) = [];
toolaxiserr = [toolaxiserr; temp2'];
end

%create angle and distance vectors
tipdist = [];
axisang = [];
for k = 1:N
tipdist = [tipdist; norm([0 -20 0] - tooltiperr(k,:))];
axisang = [axisang; real(acosd(max(min(dot([0 -1 0],toolaxiserr(k,:))/(norm([0 -1 0])*norm(toolaxiserr(k,:))),1),-1)))];
end

%find mu and sigma for both sphere and cone of uncertainty
spheredist = fitdist(tipdist, "Normal");
spheremu = spheredist.mu;
spheresigma = spheredist.sigma;

conedist = fitdist(axisang, "Normal");
conemu = conedist.mu;
conesigma = conedist.sigma;

%create a "cone" by using the angle created to make a vector
[rm, ~] = Rotation_about_Frame_Axis("x", 2*conesigma);
conevec = (rm*[0 -1 0]')';

%find height that we need to transpose cone upwards by to fit on sphere
h = 2*spheresigma/tand(2*conesigma);
conestart = [0 h 0];

%find radius of cone/tumour at height of -20
i = Intersect_Line_and_Plane([0 -20 0], [0 1 0], conestart, conevec);
tumour_radius = norm([0 -20 0] - i);

%create error in tumour centre using error marker points and distance from
%true centre of tumour
tumourcentres = [];
tumourcentredist = [];
for l = 1:N
[~, e1, e2, e3] = Generate_Orthogonal_Frame(Amtrackerr(l,:), Bmtrackerr(l,:), Cmtrackerr(l,:));
t = inv(Frame_Transformation_to_Home([0 0 0], e1, e2, e3));

tumourcentre = [0 -20 0 1];
temp = t*tumourcentre';
temp(end) = [];
tumourcentres = [tumourcentres; temp'];
tumourcentredist = [tumourcentredist; norm([0 -20 0] - tumourcentres(l,:))];
end

%find standard distribution of error centres of tumour
tumourcentresigma = fitdist(tumourcentredist, "Normal").sigma;

%find closest point never touched with near certainty
nerve_distance = 2*tumourcentresigma + tumour_radius;

%display results
fprintf('\n');
disp('Navigation Error Analysis:');

fprintf('\n');
disp('The radius of the smallest sphereical tumour we can hit with "near certainty":');
fprintf('%7.1f Cm \n', tumour_radius);
fprintf('\n');

fprintf('\n');
disp('The distance to the nearest nerve we can spare with "near certainty":');
fprintf('%7.1f Cm \n', nerve_distance);
fprintf('\n');