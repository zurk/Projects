function [] = plot_spect( X )
%PLOT_SPECT Summary of this function goes here
%   Detailed explanation goes here

%X = D(curIndx,:);% 6,7,9,12,28,31,32,55
[~,F,T,P] = spectrogram(X,128,120,512,2000);
F = F(25:129); % Hz from 93.75 to 500
P = P(25:129,:);
subplot(3,2,1);
P = 10 * log10(P);
surf(T,F,P,'edgecolor','none'); axis tight; 
view(0,90);
xlabel('Time (Seconds)'); ylabel('Hz');

 subplot(3,2,5);
 [~, mF] = max(P,[], 1);
 mF = F(1) + (F(2) - F(1)) * (mF - 1);
 plot(T, mF, 'LineWidth', 1);
 grid on;
 hold on;
 windowSize = 10;
 plot(T, filter(ones(1,windowSize)/windowSize,1,medfilt1(mF,10)),'r', 'LineWidth', 2);
 xlabel('Time (Seconds)'); ylabel('Max amplitude frequency(filtering)');
 hold off;

FrBegin = 2;
FrEnd = 29;
FrBegin2 = 32;
FrEnd2 = 67;
hight = 10;

value = zeros(length(T), 4);
for tBegin = 1:length(T)-50
    tEnd = min(floor(tBegin + 0.5 /(T(2) - T(1))), length(T));
    mask = get_template([size(P,2), size(P,1)], [tBegin, FrBegin], [tEnd, FrEnd], hight)';
    Q = mask .* P;
    value(tBegin, 1) = sum(Q(:))/sum(mask(:));
%     value(tBegin, 2) = quantile(P(mask == 1), 0.9) - quantile(P(mask == 1), 0.1);
    tEnd = min(floor(tBegin + 0.2 /(T(2) - T(1))), length(T));
    mask = get_template([size(P,2), size(P,1)], [tBegin, FrBegin2], [tEnd, FrEnd2], hight)';
    Q = mask .* P;
    value(tBegin, 3) = sum(Q(:))/sum(mask(:));
%     value(tBegin, 4) = quantile(P(mask == 1), 0.9) - quantile(P(mask == 1), 0.1);
end

subplot(3,2,3);
plot(T(1:end), value(:,[1,3]), 'LineWidth', 1.5);
grid on;
xlabel('Time (Seconds)'); ylabel('mean value in window');

% subplot(3,1,3);
% plot(T(1:end), value(:,[2,4]), 'LineWidth', 1.5);
% grid on;
% xlabel('Time (Seconds)'); ylabel('max-min value in window');

subplot(3,2,2);
[~, tBegin] = max(value(:,1));
tEnd = min(floor(tBegin + 0.5 /(T(2) - T(1))), length(T));
mask = get_template([size(P,2), size(P,1)], [tBegin, FrBegin], [tEnd, FrEnd], hight)';
Q = mask .* P;
Q = sum(Q, 1);
plot(T, Q, 'LineWidth', 1);
hold on;
grid on;
windowSize = 10;
plot(T, filter(ones(1,windowSize)/windowSize,1,medfilt1(Q)),'r', 'LineWidth', 2);
hold off;


subplot(3,2,1);
hold on;
[~, tBegin] = max(value(:,1));
tEnd = min(floor(tBegin + 0.5 /(T(2) - T(1))), length(T));
plot3(T([tBegin, tEnd, tEnd tBegin tBegin]), F([FrBegin, FrEnd, FrEnd + hight, FrBegin + hight, FrBegin]), [50,50,50,50,50],'LineWidth', 2 );
[~, tBegin] = max(value(:,3));
tEnd = min(floor(tBegin + 0.2 /(T(2) - T(1))), length(T));
plot3(T([tBegin, tEnd, tEnd tBegin tBegin]), F([FrBegin2, FrEnd2, FrEnd2 + hight, FrBegin2 + hight, FrBegin2]), [50,50,50,50,50],'LineWidth', 1 );
zlim([-50,50]);
view(0,90);
hold off;
xlim([0, 2]);
ylim([100, 500]);
