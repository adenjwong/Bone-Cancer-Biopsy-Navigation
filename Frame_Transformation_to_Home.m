function t = Frame_Transformation_to_Home(Ov, v1, v2, v3)
% Frame_Transformation_to_Home computes the transformation that takes the
% perspective from v frame to home
%
% The function creates a translation matrix using the origins and a
% rotation matrix using the three base vectors and multiplies the two in
% order to produce the 4x4 transformation matrix. The transformation matrix
% is padded in order for it to be invertible.
%
% INPUTS: 
%         Ov - centre of v frame in home frame
%         v1 - base vector in v frame
%         v2 - base vector in v frame
%         v3 - base vector in v frame
% OUTPUTS:
%         t - Frame transformation

translation = [1 0 0 Ov(1); 0 1 0 Ov(2); 0 0 1 Ov(3); 0 0 0 1];
rotation = [v1(1) v2(1) v3(1) 0; v1(2) v2(2) v3(2) 0; v1(3) v2(3) v3(3) 0; 0 0 0 1];
t = translation*rotation;
end