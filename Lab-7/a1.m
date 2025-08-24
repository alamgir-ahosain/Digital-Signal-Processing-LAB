%Given an input sequence x(n)=(1,2,3) is passed through a filter given by h(n)=(1,2).
%Find the output y(n). in matlab code 

% Take user input for x(n) and h(n)
x = input('Enter the input sequence x(n) as a vector: ');
h = input('Enter the impulse response h(n) as a vector: ');

% Get lengths
Lx = length(x);
Lh = length(h);
Ly = Lx + Lh - 1;

% Zero-pad input and impulse response
x_padded = [x, zeros(1, Lh)];
h_padded = [h, zeros(1, Lx)];

% Initialize output
y = zeros(1, Ly);

% Manual convolution
for n = 1:Ly
    for k = 1:Lx
        if (n - k + 1 > 0) && (n - k + 1 <= Lh)
            y(n) = y(n) + x(k) * h(n - k + 1);
        end
    end
end

% Display the output
disp('The output y(n) = ');
disp(y);
