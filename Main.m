clc;
clear all;
f=imread('Image path'test1.tif');
k = localhisteq(f,3,3);

j = localhisteq(f,7,7);
l = histeq(f);
subplot(1,4,1);
imshow(f);
title('original');

subplot(1,4,2);
imshow(k);
title('3x3');

subplot(1,4,3);
imshow(j);
title('7x7');

subplot(1,4,4);
imshow(l);
title('global histogram');
