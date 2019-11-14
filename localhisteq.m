function g = localhisteq(f, m, n)
%LOCALHISTEQ Local histogram equalization.
% G = LOCALHISTEQ(F, M, N) performs local histogram equalization
% on input image F using a window of (odd) size M-by-N to produce
% the processed image, G. To handle border effects, image F is
% extended by using the symmetric option in function padarray.
% The amount of extension is determined by the dimensions of the
% local window. If M and N are omitted, they default to
% 3. If N is omitted, it defaults to M. Both must be odd.
%
% This function accepts input images of class uint8, uint16, or
% double. However, all computations are done using 8-bit intensity
% values to speed-up computations. If F is of class double its
% values should be in the range [0 1]. The class of the output
% image is the same as the class of the input.
if nargin == 1                          % Check the number of arguments input into M-functions
 m = 3; n = 3
elseif nargin == 2
 n = m;
end
if ~(round(m/2) ~= m/2) | ~(round(n/2) ~= n/2)      % rounds each element of X to the nearest integer
 error('It should be odd dimension of neighborhood')
end
classin = class(f);                                 % For use later.
f = im2uint8(f);                                    %Work with 8-bit accuracy.
                                                    % Extend the borders of the input image.
[R C] = size(f);                                    % For use later.
f = padarray(f, [m n], 'symmetric', 'both');        % add m and n elements of padding to the end of the second dimention
 % using symmetric, pad by repeating border elements of array and using
 % 'both', pad before first element and after last element
        % Move the window from pixel to pixel and histogram equalize at
        % each location.
yj = 0;
den = m*n;
for x = (m + 1)/2 + 1 : R + (m + 1)/2
 yj = yj + 1;
 yg = 0;
 for y = (n + 1)/2 + 1 : C + (n + 1)/2
 yg = yg + 1;
 subimage = f(x:x + m - 1, y:y + n - 1);
 h = histeq2(subimage); % Can also use imhist, but watch the scaling.
 % Pick the value in the center of the equalized subimage. Function
 % histeq contains the necessary mapping function.
 g(yj, yg) = h((m + 1)/2, (n + 1)/2);
 end
end
% Convert back to the class of the input.
g = changeclass(classin, g);
