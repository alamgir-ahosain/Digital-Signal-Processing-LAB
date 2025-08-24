clc; clear;

% Input sequence
x = [1, 1, -1, -1];
N = length(x);
disp('Input sequence:');
disp(x);

% 1. FFT using 4-point DIT (Decimation-in-Time)
% Bit reversal order: index [0 2 1 3] for 4 points
x_br = x([1 3 2 4]);  % MATLAB is 1-based indexing

% Stage 1
X1_0 = x_br(1) + x_br(2);
X1_1 = x_br(1) - x_br(2);
X1_2 = x_br(3) + x_br(4);
X1_3 = x_br(3) - x_br(4);

% Stage 2 with twiddle factors
W = exp(-1j*2*pi*(0:N-1)/N);
X(1) = X1_0 + W(1)*X1_2;
X(2) = X1_1 + W(2)*X1_3;
X(3) = X1_0 - W(1)*X1_2;
X(4) = X1_1 - W(2)*X1_3;

disp('FFT using DIT algorithm:');
disp(X);

% 2. DFT Method (Direct computation)
X_dft = zeros(1,N);
for k = 0:N-1
    for n = 0:N-1
        X_dft(k+1) = X_dft(k+1) + x(n+1)*exp(-1j*2*pi*k*n/N);
    end
end
disp('DFT Result:');
disp(X_dft);

% 3. Z-Transform Method
% Evaluate Z-transform at z = exp(-j2πk/N)
X_z = zeros(1,N);
for k = 0:N-1
    z = exp(-1j*2*pi*k/N);
    for n = 0:N-1
        X_z(k+1) = X_z(k+1) + x(n+1)*z^(-n);
    end
end
disp('Z-Transform evaluated at unit circle:');
disp(X_z);

% 4. Convolution Method (circular convolution with impulse)
h = [1 0 0 0]; % impulse
x_conv = zeros(1,N);
for n = 0:N-1
    for m = 0:N-1
        x_conv(n+1) = x_conv(n+1) + x(mod(n - m, N)+1) * h(m+1);
    end
end
% Now apply FFT to result
X_conv = fft(x_conv);
disp('Circular Convolution + FFT:');
disp(X_conv);

% Compare all results
fprintf('\nCompare Results:\n');
disp(table((0:N-1)', X.', X_dft.', X_z.', X_conv.', ...
    'VariableNames', {'Index_k', 'DIT_FFT', 'DFT', 'Z_Transform', 'Conv+FFT'}));
