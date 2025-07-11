clc;
clear;

% -------- Step 1: Select Image from File Manager --------
[file, path] = uigetfile({'*.jpg;*.png;*.bmp'}, 'Select Image');
if isequal(file,0)
    disp('No image selected');
    return;
end
img = imread(fullfile(path, file));
if size(img,3) == 3
    img = rgb2gray(img);
end
img = im2double(img);
[H, W] = size(img);

% -------- Step 2: User Inputs --------
blockSize = input('Enter block size for DCT (e.g., 8): ');
waveletName = input('Enter wavelet name for DWT (e.g., ''haar'', ''db1''): ', 's');
k = input('Enter number of singular values to keep in SVD (e.g., 20): ');
attack_type = input('Enter attack type (gaussian / saltpepper / resize / rotate): ', 's');

% -------- a. Block-based DCT --------
dct_img = zeros(H, W);
for i = 1:blockSize:H-blockSize+1
    for j = 1:blockSize:W-blockSize+1
        block = img(i:i+blockSize-1, j:j+blockSize-1);
        dct_block = dct2(block);
        dct_img(i:i+blockSize-1, j:j+blockSize-1) = idct2(dct_block);
    end
end

% -------- b. 3-Level DWT --------
[LL1,LH1,HL1,HH1] = dwt2(img, waveletName);
[LL2,~,~,~] = dwt2(LL1, waveletName);
[LL3,~,~,~] = dwt2(LL2, waveletName);
dwt_img = idwt2(idwt2(idwt2(LL3,[],[],[],waveletName),[],[],[],waveletName),[],[],[],waveletName);

% -------- c. 2-Level SVD --------
[U1, S1, V1] = svd(img);
S1(k+1:end, :) = 0; S1(:, k+1:end) = 0;
svd1 = U1 * S1 * V1';

[U2, S2, V2] = svd(svd1);
S2(k+1:end, :) = 0; S2(:, k+1:end) = 0;
svd2 = U2 * S2 * V2';

% -------- Combined Transformed Image --------
transformed = svd2;

% -------- Step 3: Apply Attack --------
switch lower(attack_type)
    case 'gaussian'
        attacked = transformed + 0.05 * randn(size(transformed));
    case 'saltpepper'
        density = 0.02;
        attacked = transformed;
        r = rand(size(attacked));
        attacked(r < density/2) = 0;
        attacked(r > 1 - density/2) = 1;
    case 'resize'
        attacked = imresize(transformed, 0.8);
        attacked = imresize(attacked, [H W]);
    case 'rotate'
        temp = imrotate(transformed, 10, 'bilinear', 'crop');
        attacked = imresize(temp, [H W]);
    otherwise
        disp('Unknown attack. Skipping...');
        attacked = transformed;
end

% Clip attacked values
attacked = min(max(attacked, 0), 1);

% -------- Step 4: Calculate SSIM and NC --------
ssim_val = ssim(attacked, img);

numerator = sum(sum(attacked .* img));
denominator = sqrt(sum(sum(attacked.^2)) * sum(sum(img.^2)));
nc_val = numerator / denominator;

% -------- Step 5: Show Results --------
figure('Name','Image Processing and Attack');
subplot(2,3,1); imshow(img); title('Original Image');
subplot(2,3,2); imshow(dct_img); title('After DCT');
subplot(2,3,3); imshow(dwt_img); title('After 3-Level DWT');
subplot(2,3,4); imshow(svd2); title('After 2-Level SVD');
subplot(2,3,5); imshow(attacked); title(['Attacked Image (' attack_type ')']);
subplot(2,3,6); imshow(abs(attacked - img)); title('Difference Image');

% -------- Step 6: Print Metrics --------
fprintf('\n🔍 SSIM between Original and Attacked Image: %.4f\n', ssim_val);
fprintf('📐 NC between Original and Attacked Image: %.4f\n', nc_val);
