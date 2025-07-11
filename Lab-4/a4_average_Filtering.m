
img = imread("bird2.jpg");
img = double(img);
[row, col, cp] = size(img);


    
kernel_size = input('Enter kernel size (odd number like 3, 5, 7): ');

% check valid (must be odd and >= 3)
if mod(kernel_size, 2) == 0 || kernel_size < 3
    error('Kernel size must be an odd number >= 3');
end

pad = floor(kernel_size / 2);  % Amount of padding
% --------------- Manual Zero Padding ----------------
padded_img = zeros(row + 2*pad, col + 2*pad, cp);

for k = 1:cp
    for i = 1:row
        for j = 1:col
            padded_img(i + pad, j + pad, k) = img(i, j, k);
        end
    end
end

% --------------- Average/Mean Filtering ----------------
avg_img = zeros(size(img));

for k = 1:cp
    for i = 1:row
        for j = 1:col
            block = padded_img(i:i + 2*pad, j:j + 2*pad, k);
            %avg_img(i,j,k)=sum(block(:))/9;
            avg_img(i, j, k) = sum(block(:)) / (kernel_size * kernel_size);
        end
    end
end

% --------------- Display ----------------
figure;
subplot(2, 2, 1), imshow(uint8(img)), title("Original Image");
subplot(2, 2, 2), imshow(uint8(avg_img)), title("Average/Mean Filtering");
