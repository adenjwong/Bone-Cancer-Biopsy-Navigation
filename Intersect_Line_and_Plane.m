function i = Intersect_Line_and_Plane(A, n, P, v)
% Intersect_Line_and_Plane calculates the intersection between a line and a
% plane
%
% Uses a dot product in order to find the point where the line meets the
% plane. If the result is inf than there is an infinite number of
% intersections and the line lies on the plane, if the result is nan than
% the line does not intersect with the plane, otherwise the function will
% substitute the value into the formula for the line and return the
% intersection point.
%
% INPUTS: 
%         A - point used to define the plane
%         n - the plane's normal vector
%         P - fixed point used to define the line 
%         v - direction vector used to define the line
% OUTPUTS:
%         i - point of intersection between line and plane

t = dot((A-P), n) / dot(v, n);
if isinf(t)
    disp("Line is in plane, there are an infinite number of intersections")
    i = nan;
elseif isnan(t)
    disp("Line does not intersect with plane")
    i = nan;
else
    i = P + t*v;
end

end