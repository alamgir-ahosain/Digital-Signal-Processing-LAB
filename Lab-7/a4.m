% MATLAB Program to calculate DFT from user input and plot magnitude and phase

%Time domain to frequency domain
%x = input('Enter the sequence as space-separated values (e.g., [1 2 3 4]: ');
str = input('Enter the sequence as space-separated values (e.g., 1 2 3 4): ', 's'); 
x = str2num(str); % convert to numeric vector
N = length(x);          % Length of the sequence
X = zeros(1, N);        % Initialize DFT output

% Calculate DFT manually
for k = 0:N-1
    for n = 0:N-1
        X(k+1) = X(k+1) + x(n+1)*exp(-1j*2*pi*k*n/N);
        %matlab index start from 1
    end
end

% Frequency index for plotting
f = 0:N-1;

%show how each frequency component
% Plot magnitude
figure;
subplot(2,1,1);
stem(f, abs(X), 'filled');
title('Magnitude of DFT');
xlabel('Frequency index (k)');
ylabel('|X(k)|');
grid on;

%Phase spectrum: Shows the phase shift of each frequency component.
% Plot phase
subplot(2,1,2);
stem(f, angle(X), 'filled');
title('Phase of DFT');
xlabel('Frequency index (k)');
ylabel('Phase of X(k) (radians)');
grid on;
