
rgb_img = imread('i2.jpg');

% Convert to grayscale
R = double(rgb_img(:,:,1));
G = double(rgb_img(:,:,2));
B = double(rgb_img(:,:,3));
gray_img = uint8(0.2989 * R + 0.5870 * G + 0.1140 * B);

% Convert grayscale image to double for computation
img_double = double(gray_img);

imin = min(img_double(:));  
imax = max(img_double(:));

fprintf('Min gray level: %f\n', imin);
fprintf('Max gray level: %f\n', imax);

% Avoid division by zero
if imin ~= imax
    stretched_img = (img_double - imin) / (imax - imin) * 255;
else
    stretched_img = img_double; % No contrast stretching possible
end

stretched_img = uint8(stretched_img);

% Display images
figure;
subplot(2,2,1); imshow(gray_img); title('Original Grayscale Image');
subplot(2,2,3); imhist(gray_img); title('Original Histogram');

subplot(2,2,2); imshow(stretched_img); title('Contrast Stretched Image');
subplot(2,2,4); imhist(stretched_img); title('Stretched Histogram');


