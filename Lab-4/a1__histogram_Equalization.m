
rgb_img = imread('bird2.jpg');

% convert gray scale using luminosity method
R = double(rgb_img(:,:,1));
G = double(rgb_img(:,:,2));
B = double(rgb_img(:,:,3));
gray_img = uint8(0.2989 * R + 0.5870 * G + 0.1140 * B);

% X axis : gray level pixel intensity,dark to bright
% Y axis : number of pixel in each gray level (frequency occurance in gray level)
%   equalize the probabily of occurance of different gray level
%   Redistributes intensities to equalize contrast


[M, N] = size(gray_img);
total_pixels = M * N;

% Step 1: Compute histogram of the grayscale image
hist = zeros(1, 256);  % For pixel values [0–255]

for i = 1:M
    for j = 1:N
        intensity = gray_img(i,j);
        hist(intensity + 1) = hist(intensity + 1) + 1;  % MATLAB indexing starts at 1
    end
end

% Step 2: Compute cumulative distribution function (CDF)
cdf = zeros(1, 256);
cdf(1) = hist(1);
for k = 2:256
    cdf(k) = cdf(k - 1) + hist(k);
end

% Step 3: Normalize the CDF
cdf_min = min(cdf(cdf > 0));  % Ignore zeros
cdf_normalized = round((cdf - cdf_min) / (total_pixels - cdf_min) * 255);

% Step 4: Map original gray levels to equalized values
eq_gray_img = zeros(M, N, 'uint8');
for i = 1:M
    for j = 1:N
        eq_gray_img(i,j) = cdf_normalized(gray_img(i,j) + 1);
    end
end

% Step 5: Compute histograms for display
orig_hist = hist;  % Already computed
eq_hist = zeros(1, 256);
for i = 1:M
    for j = 1:N
        eq_hist(eq_gray_img(i,j) + 1) = eq_hist(eq_gray_img(i,j) + 1) + 1;
    end
end


figure;
subplot(2,2,1); imshow(gray_img); title('Original Grayscale Image');
subplot(2,2,3); bar(orig_hist); title('Original Histogram'); xlim([0 255]);

subplot(2,2,2); imshow(eq_gray_img); title('Equalized Grayscale Image');
subplot(2,2,4); bar(eq_hist); title('Equalized Histogram'); xlim([0 255]);
%xlim([0 255]) fixes x-axis range to pixel intensity levels.

