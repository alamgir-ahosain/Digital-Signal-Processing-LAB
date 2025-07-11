img=imread("bird2.jpg");
img=double(img);
[row,col,cp]=size(img);

%{

h = fspecial('average', [3 3]);
avg_builtin(:,:,k) = imfilter(img(:,:,k), h, 'replicate');

%median
med_builtin(:,:,k) = medfilt2(img(:,:,k), [3 3])

%LPGF,
h = fspecial('gaussian', [3 3], sigma);
gauss_builtin(:,:,k) = imfilter(img(:,:,k), h, 'replicate');

%}



%        _________________Without Builtin_________________

%avegrage filtering=mean filtering 
% create 3x3 avegare block
avg_img=zeros(size(img));
for k=1:cp
    for i=2:row-1
        for j=2:col-1
            block=img(i-1:i+1  , j-1:j+1 , k);
            avg_img(i,j,k)=sum(block(:))/9;
        end
    end
end



%median Filtering
% create 3x3 median block
med_img=zeros(size(img));
for k=1:cp
    for i=2:row-1
        for j=2:col-1
            block=img(i-1:i+1  , j-1:j+1 , k);
            med_img(i,j,k)=median(block(:));
        end
    end
end


% LPGF-Low Pass Gaussian Filter) 
% sigma = 1.0, controls blur intensity. (standard deviation)
% G(x,y)=e(-x2+y2/2*sigma2​

gauss_img=zeros(size(img));
sigma=1.0;
[X,Y]=meshgrid(-1:1 , -1:1); %create 3*3 kernal matrix
gauss_kernal=exp(-(X^2+Y^2)/(2*sigma^2));
gauss_kernal=gauss_kernal/sum(gauss_kernal(:));% Normalize to sum = 1

for k=1:cp
    for i=2:row-1
        for j=2:col-1
             block=img(i-1:i+1  , j-1:j+1 , k);
           % gauss_img(i,j,k)=sum(sum(block*gauss_kernal));
            gauss_img(i,j,k) = sum(sum(block .* gauss_kernal));

        end
    end
end





figure;
subplot(2, 2, 1), imshow(uint8(img)), title("Original Image");
subplot(2, 2, 2), imshow(uint8(avg_img)), title("Average/Mean Filtering");
subplot(2, 2, 3), imshow(uint8(avg_img)), title("Median Filtering");
subplot(2, 2, 4), imshow(uint8(gauss_img)), title("LPGF Filtering");
