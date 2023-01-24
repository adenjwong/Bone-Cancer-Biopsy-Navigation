
%Code used for Axis calibration
%Author: Sam Murthy
%https://www.mathworks.com/matlabcentral/fileexchange/55304-best-fit-3d-circle-to-a-set-of-points

function [centerLoc, circleNormal, radius] = CircFit3D(circLocs)
% extends circFit() to provide the best fit for a circle in R3.
% circLocs nx3: x, y, z coordinates
meanLoc = mean(circLocs);
numCurPts = length(circLocs);
movedToOrigin = circLocs - ones(numCurPts, 1)*meanLoc;
% plot3(curLocs(:, 2), curLocs (:, 3), curLocs (:, 4)); grid on;
% xlabel('x'); ylabel('y'); zlabel('z');
[U, s, V]= svd(movedToOrigin);
circleNormal = V(:, 3);
circleLocsXY = RodriguesRotation(movedToOrigin, circleNormal, [0, 0, 1]);
[xc, yc, radius] = circFit(circleLocsXY(:, 1), circleLocsXY(:, 2));
centerLoc = RodriguesRotation([xc, yc, 0], [0,0,1], circleNormal) + meanLoc;
end

function   [xc,yc,R,a] = circFit(x,y)
%
%   [xc yx R] = circfit(x,y)
%
%   fits a circle  in x,y plane in a more accurate
%   (less prone to ill condition )
%  procedure than circfit2 but using more memory
%  x,y are column vector where (x(i),y(i)) is a measured point
%
%  result is center point (yc,xc) and radius R
%  an optional output is the vector of coeficient a
% describing the circle's equation
%
%   x^2+y^2+a(1)*x+a(2)*y+a(3)=0
%
%  By:  Izhak bucher 25/oct /1991, 
    x=x(:); y=y(:);
   a=[x y ones(size(x))]\[-(x.^2+y.^2)];
   xc = -.5*a(1);
   yc = -.5*a(2);
   R  =  sqrt((a(1)^2+a(2)^2)/4-a(3));
end

function rotatedPts = RodriguesRotation(providedPts, origNormal, newNormal)
% rotate provided points based on a staring and ending vector
origNormal = origNormal/norm(origNormal);
newNormal = newNormal/norm(newNormal);
numProvidedPts = size(providedPts, 1);
theta = acos(dot(origNormal, newNormal) );
rotationNormal = cross(origNormal, newNormal);
rotationNormal = rotationNormal / norm(rotationNormal );
if ~sum(isnan(rotationNormal)),
    rotatedPts = providedPts.*(cos(theta)*ones(numProvidedPts, 3)) + ...
        cross(ones(numProvidedPts,1)*rotationNormal, providedPts, 2) .* (sin(theta)*ones(numProvidedPts, 3)) + ...
        (ones(numProvidedPts,1)*rotationNormal) .* (dot(ones(numProvidedPts,1)*rotationNormal, providedPts, 2)*ones(1, 3)) .* ...
        ((1-cos(theta))*ones(numProvidedPts, 3)); % Rodrigues' formula
else
    rotatedPts = providedPts;
end
end