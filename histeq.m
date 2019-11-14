function h = histeq(f)
%HISTEQ2 Histogram equalization.
% H = HISTEQ(F) histogram-equalizes F and outputs the result
% in H. Unlike IPT function histeq, HISTEQ implements the direct,
% "standard" histogram equalization approach.F can be of class uint8,
% uint16, or double. If F is double,
% then its values are assumed to be in the range [0 1]. The intensity
% range of the input image (regardless of class) is divided into 256
% increments for computing the histogram and the corresponding cumulative
% distribution function (CDF). Recall that the CDF is actually the mapping
% function used for histogram equalization.
%
classin = class(f);
f = im2uint8(f);
% The histogram and the cumulative distribution function.
den = numel(f);
hst = imhist(f, 256) / den;
cdf = cumsum(hst); % Values are in the range [0 1].
% Now map the values of the input image to obtain the histogram-
% equalized image, g.
h = intxform(f, cdf);
% Convert to the class of the input
h = changeclass(classin, h);
