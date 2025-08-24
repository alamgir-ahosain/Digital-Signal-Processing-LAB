clc; clear; close all;

% --- User Input ---
f = input('Enter frequency of the signal in Hz (e.g., 50): ');
fs1 = input('Enter sampling rate at Nyquist rate (e.g., 2*f): ');
fs2 = input('Enter sampling rate below Nyquist (e.g., 1.5*f): ');
fs3 = input('Enter sampling rate above Nyquist (e.g., 5*f): ');

% High-resolution time vector (for original signal)
t = 0:1/(20*f):0.1;
x = cos(2*pi*f*t);   % Original analog signal

% Sampling at different rates
n1 = 0:1/fs1:0.1;
x1 = cos(2*pi*f*n1);   % Nyquist sampling

n2 = 0:1/fs2:0.1;
x2 = cos(2*pi*f*n2);   % Under-sampling

n3 = 0:1/fs3:0.1;
x3 = cos(2*pi*f*n3);   % Over-sampling

% --- Plotting ---
figure;

subplot(4,1,1);
plot(t, x, 'k', 'LineWidth', 1.5); grid on;
title('Original Signal (Analog)');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,2);
stem(n1, x1, 'b', 'filled'); hold on;
plot(t, x, 'k--'); grid on;
title(['Sampling at Nyquist Rate: f_s = ', num2str(fs1), ' Hz']);
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,3);
stem(n2, x2, 'r', 'filled'); hold on;
plot(t, x, 'k--'); grid on;
title(['Under-Sampling: f_s = ', num2str(fs2), ' Hz (Aliasing)']);
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,4);
stem(n3, x3, 'g', 'filled'); hold on;
plot(t, x, 'k--'); grid on;
title(['Over-Sampling: f_s = ', num2str(fs3), ' Hz']);
xlabel('Time (s)'); ylabel('Amplitude');
