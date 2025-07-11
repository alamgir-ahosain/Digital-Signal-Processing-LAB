img=imread("bird2.jpg");
img=im2double(img);
[row,col,cp]=size(img);
noisy_img = imnoise(img, 'gaussian', 0, 0.01);

%{
mean_builtin = imfilter(noisy_img, fspecial('average', [3 3]), 'replicate');
median_builtin = medfilt2(noisy_img, [3 3]);


%}

%Remove with Mean filter
mean_filter = zeros(size(img));
for k=1:cp
 for i = 2:row-1
    for j = 2:col-1
        block = noisy_img(i-1:i+1, j-1:j+1,k);
        mean_filter(i, j,k) = mean(block(:));
    end
 end
end


% Remove with Median filter
median_filter = zeros(size(img));
for k = 1:cp
    for i = 2:row-1
        for j = 2:col-1
            block = noisy_img(i-1:i+1, j-1:j+1, k);
            median_filter(i, j, k) = median(block(:));
        end
    end
end


% Remove with Gaussian filter ()

gauss_img=zeros(size(noisy_img));
sigma=1.0;
[X,Y]=meshgrid(-1:1 , -1:1);
gauss_kernal=exp(-(X.^2+Y.^2)/(2*sigma^2));
gauss_kernal=gauss_kernal/sum(gauss_kernal(:));% Normalize to sum = 1

for k=1:cp
    for i=2:row-1
        for j=2:col-1
             block=noisy_img(i-1:i+1  , j-1:j+1 , k);
            gauss_img(i,j,k)=sum(sum(block.*gauss_kernal));
        end
    end
end






subplot(3, 3, 1), imshow(img), title("Original Image");
subplot(3, 3, 2), imshow(noisy_img), title("Noisy Image");
subplot(3, 3, 3), imshow(mean_filter), title("Remove using Mean filtering ");
subplot(3, 3, 4), imshow(median_filter), title("Remove using Median filtering ");
subplot(3, 3, 6), imshow(gauss_img), title("Remove using Gauss filtering ");
