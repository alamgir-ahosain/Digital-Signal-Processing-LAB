

start_t = input('Enter start value of t(0): ');
end_t = input('Enter end value of t(2*pi): ');
step_t = input('Enter step size(0.01): ');


t = start_t:step_t:end_t;
y_sin = 0;
for n = 0:10
    y_sin = y_sin + ((-1)^n * t.^(2*n+1)) / factorial(2*n+1);
end

y_cos = 0;
for n = 0:10
    y_cos = y_cos + ((-1)^n * t.^(2*n)) / factorial(2*n);
end

figure;
subplot(2,1,1);
line(t, y_sin, 'Color', 'r', 'LineWidth', 2); 
title('Sine Wave (Taylor Approximation)'); xlabel('Time (t)'); ylabel('Amplitude'); grid on;

subplot(2,1,2);
line(t, y_cos, 'Color', 'b', 'LineWidth', 2); 
title('Cosine Wave (Taylor Approximation)'); xlabel('Time (t)'); ylabel('Amplitude'); grid on;
