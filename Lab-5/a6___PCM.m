
       disp('--- PCM Encoding and Decoding of an Analog signal ---');

signal_type = input('Enter signal type (sin/cos): ', 's');
A = input('Enter amplitude: (1.5)');
f = input('Enter frequency (5 Hz): ');
T = input('Enter duration (1 seconds): ');
bits = input('Enter number of bits for quantization(4 bits=2^4=16): ');
if bits < 1 || bits > 16
    error('Bits should be between 1 and 16.');
end

% --- Time Vector and Analog Signal ---
fs = input('Enter sampling frequency(1000 Hz:)');
t = 0:1/fs:T;                   % Time vector

% Generate signal
if strcmpi(signal_type, 'sin')
    analog_signal = A * sin(2*pi*f*t);
elseif strcmpi(signal_type, 'cos')
    analog_signal = A * cos(2*pi*f*t);
else
    error('Choose sine or cosine.');
end

% --- Quantization ---
%mapped finite set of discreate value
L = 2^bits;                     % Number of quantization levels
xmin = min(analog_signal);
xmax = max(analog_signal);
q_step = (xmax - xmin) / (L - 1);

% Quantize
quantized_signal = round((analog_signal - xmin) / q_step) * q_step + xmin;

% --- PCM Encoding (Decimal to Binary) ---
quantized_indices = round((quantized_signal - xmin) / q_step);
binary_encoded = dec2bin(quantized_indices, bits);

% --- PCM Decoding (Binary to Decimal) ---
decoded_indices = bin2dec(binary_encoded);
decoded_signal = decoded_indices * q_step + xmin;

% --- Plotting ---
figure;
subplot(3,1,1);
plot(t, analog_signal);
title('Original Analog Signal'); grid on;
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(3,1,2);
stairs(t, quantized_signal);
title('Quantized Signal'); grid on;
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, decoded_signal, 'r');
title('Reconstructed (Decoded) Signal'); grid on;
xlabel('Time (seconds)');
ylabel('Amplitude');