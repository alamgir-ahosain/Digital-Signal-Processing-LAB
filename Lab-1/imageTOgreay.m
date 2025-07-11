% 1.  Image read, write, display, dimension change (rgb to gray), resize.

       %with builtin
%{
img = imread('bird2.jpg');
subplot(2,2,1);
imshow(img);
title('Original Image');

img2= im2gray(img);
subplot(2,2,2);
imshow(img2);
title('Gray Image ');
%}


       %{
         R=8 ,G=8 ,B=8 so  RGB=8+8+8=24 pixel
         so RGB to greay= 100/3=33.33 %
       %}
img = imread('bird2.jpg');
% convert to grayscale
R=img(:, :, 1); % 256,256,1 no index
G=img(:, :, 2);
B=img(:, :, 3);

new_image=zeros(size(img,1),size(img,2),'uint8');
% disp(new_image)
for i=1:size(img,1)
    for j=1:size(img,2)
        new_image(i,j) = (R(i,j)*0.33+G(i,j)*0.33+B(i,j)*0.33);
    end
end

subplot(2,2,1);
imshow(img);
title('Original Image');

% Display grayscale image
subplot(2,2,2);
imshow(new_image);
title('Gray Image (without Builtin)');

% Display grayscale image

img2=im2gray(img);

subplot(2,2,4);
imshow(img2);
title('Gray Image (with builtin)');

