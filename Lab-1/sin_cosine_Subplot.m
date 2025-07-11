
% 4.  Create a sine wave and cosine wave; Plot sinusoidal wave in a single graph usingsubplot.
A=input('Enter Amplitudde :');
F=input('Enter Frequency: ');
t=0:0.1:1;

% Sine Wave
Y_sineWave=A*sin(2*pi*F*t);
                         % 2 row 2 col and 1 meand 1 point
tiledlayout(2,2) %subplot(2,2,1)
nexttile
plot(t,Y_sineWave);
title('sine Wave')
xlabel('Time');
ylabel('Amplitude');
grid on

% Cosine Wave
nexttile % subplot(2,2,2),subplot(2,2,3),subplot(2,2,4)
Y_cosWave=A*cos(2*pi*F*t); 
plot(t,Y_cosWave);
title('cosine Wave')
xlabel('Time');
ylabel('Amplitude');
grid on