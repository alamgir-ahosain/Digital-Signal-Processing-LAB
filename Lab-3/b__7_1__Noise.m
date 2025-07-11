img=imread("bird2.jpg");
img=im2double(img);
[row,col,cp]=size(img);

%{
spn = imnoise(img, 'salt & pepper', 0.05);
gn = imnoise(img, 'gaussian', 0, 0.01); Mean = 0, Variance = 0.01.
pn_builtin = imnoise(img, 'poisson');
sn_builtin = imnoise(img, 'speckle', 0.04);



%}


% Salt and Pepper Noise (SPN)
%Randomly turns pixels  black (0) or white (1).
spn=img;
percentage=input('how percentage pixel will be noisy: ');
noise_prob=percentage/100;

for i=1:row
    for j=1:col
        r=rand;
        if r<noise_prob/2
            spn(i,j,:)=0;
        elseif r<noise_prob
            spn(i,j,:)=1;

        end
    end
end

% Gaussian Noise (GN)
  % Additive noise
  % gn_image=original + noise

  % Mean=average of the noise usually 0
  % variance=higher v. higher noise
% Continuous noise with a normal distribution.

variance=input('enter variance for GN value(0.01) : ');
gn=img+sqrt(variance)*randn(size(img)); % normal distribution
gn=min(max(gn,0),1); % Clip values to stay between 0 and 1,image must be 0/1




%4. Speckle Noise (SN)
    % Multiplicative noise
    % sn_image = original + (original × noise)

variance2=input('enter variance for SN value(0.01) : ');
sn=img+img.*sqrt(variance2).*rand(size(img));
sn=min(max(sn,0),1); % Clip values to stay between 0 and 1









% Poisson Noise (PN)
%pn = poissrnd(img * 255) / 255;
%pn = min(max(pn, 0), 1);

img_scaled = img * 255; % Scale to [0,255]
pn = zeros(size(img));   

%To generate a Poisson random variable with mean λ:
for i = 1:row
    for j = 1:col
        for k = 1:cp
            lambda = img_scaled(i,j,k); %mean for the Poisson distribution
            L = exp(-lambda);   %probability of 0 events
            p = 1;
            n = 0;
            while p > L
                n = n + 1;
                p = p * rand();
            end
            pn(i,j,k) = (n - 1);  % Poisson sample
        end
    end
end


pn = pn / 255;           % Scale back to [0,1]
pn = min(max(pn, 0), 1); % Clip values

subplot(3, 3, 1), imshow(img), title("Original Image");
subplot(3, 3, 2), imshow(spn), title("Salt and Pepper Noise");
subplot(3, 3, 3), imshow(gn), title("Gaussian Noise");
subplot(3, 3, 4), imshow(sn), title("Speckle Noise");
subplot(3, 3, 5), imshow(pn), title("Poisson Noise");

