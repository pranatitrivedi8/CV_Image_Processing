function z = intxform (s, map)
%INTXFORM Intensity transformation.
% Z = INTXFORM(S, MAP) maps the intensities of input image S using
% mapping function, MAP, whose values are assumed to be in the range
% [0 1].  For example, to create a map function that
% squares the input intensities of an input image of class uint8 and
% then use function INTXFORM to perform the mapping we write:
%
% t = linspace(0, 1, 256);
% map = t.^2;
% z = intxform(s, map);

classin = class(s); % For use later.
s = im2double(s);
% Construct x and y vectors, representing the intensity
% transformation, to be used with INTERP1. Make sure they are both
% column vectors.
x = linspace(0, 1, numel(map))';
y = map(:);
% Apply the intensity transformation using INTERP1.
z = interp1(x, y, s, 'linear');
% Change to class of the input.
z = changeclass(classin, z);
