% Read the input image
img = imread('question.png');  % Use any image you have

% Save the image using JPEG compression
imwrite(img, 'compressed.jpg', 'Quality', 30);  % Compress with quality 30/100

% Read the compressed image
compressed_img = imread('compressed.jpg');

% Display original and compressed images
figure;
subplot(1,2,1); imshow(img); title('Original Image');
subplot(1,2,2); imshow(compressed_img); title('JPEG Compressed Image');
