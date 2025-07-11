

img = imread("bird2.jpg");
[row, col, cp] = size(img);

shift_x=input('Enter vertical shift amount:');
shift_y=input('Enter horiozontal shift amount:');

type = input('Enter h for Horizontal, v for vertical and d for diagonal and c for Ciculer shifting: ', 's');


% Shift amounts
%shift_x = 30;  % Vertical shift (downward)
%shift_y = 50;  % Horizontal shift (to the right)



%{
% Horizontal shift
shift_img = circshift(img, [0, shift_y]);
shift_img=shift(1:row,1+10:col+10:);

% Vertical shift
shift_img = circshift(img, [shift_x, 0]);

% Diagonal shift (both directions)
shift_img = circshift(img, [shift_x, shift_y]);
%}




% Initialize shifted image
shift_img = zeros(size(img), "uint8");


% Horizontal shift 
% move pixels down by subtracting shift_y from the col index.
if lower(type) == 'h'
    for k = 1:cp
        for i = 1:row
            for j = 1:col
                new_j = j + shift_y;  % Changed to + for right shift
                if new_j > 0 && new_j <= col
                    shift_img(i, j, k) = img(i, new_j, k);
                end
            end
        end
    end
    
% Vertical shift ,
% move pixels down by subtracting shift_x from the row index.
elseif lower(type) == 'v'
    for k = 1:cp
        for i = 1:row
            for j = 1:col
                new_i = i + shift_x;  % Changed to + for downward shift
                if new_i > 0 && new_i <= row
                    shift_img(i, j, k) = img(new_i, j, k);
                end
            end
        end
    end
    
% Diagonal shift
elseif lower(type) == 'd'
    for k = 1:cp
        for i = 1:row
            for j = 1:col
                new_i = i + shift_y;
                new_j = j + shift_x;
                if new_i > 0 && new_i <= row && new_j > 0 && new_j <= col
                    shift_img(i, j, k) = img(new_i, new_j, k);
                end
            end
        end
    end



    % Circular shift (both directions)
elseif lower(type) == 'c'
    for k = 1:cp
        for i = 1:row
            for j = 1:col
                % Apply circular shifts in both directions
                new_i = mod(i + shift_x - 1, row) + 1;  % Circular vertical shift
                new_j = mod(j + shift_y - 1, col) + 1;  % Circular horizontal shift
                shift_img(i, j, k) = img(new_i, new_j, k);
            end
        end
    end


    
else
    error('Invalid input. Please enter h, v, or d.');
end









% Display results
figure;
subplot(1, 2, 1), imshow(img), title("Original Image");
subplot(1, 2, 2), imshow(shift_img), title(['Shifted Image, (' type ')']);
