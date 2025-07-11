% Input image (example)
image = [
    1, 3, 2, 4;
    5, 6, 7, 8;
    9, 10, 11, 12;
    13, 14, 15, 16
];

% Filter parameters
windowSize = 3;  % Define the size of the window
[rows, cols] = size(image);  % Get the size of the image
filteredImage = zeros(rows, cols);  % Initialize the filtered image

% Apply the median filter manually
for i = 1:rows
    for j = 1:cols
        % Define the window range for both rows and columns
        rowStart = max(1, i - floor(windowSize / 2));
        rowEnd = min(rows, i + floor(windowSize / 2));
        colStart = max(1, j - floor(windowSize / 2));
        colEnd = min(cols, j + floor(windowSize / 2));
        
        % Extract the window from the image
        window = image(rowStart:rowEnd, colStart:colEnd);
        
        % Calculate the median for the window
        filteredImage(i, j) = median(window(:));  % Flatten the window and calculate median
    end
end

% Display the original and filtered image
figure;

subplot(1, 2, 1);
imshow(image, []);  % Display the original image as grayscale
title('Original Image');

subplot(1, 2, 2);
imshow(filteredImage, []);  % Display the filtered image as grayscale
title('Filtered Image (Median)');
