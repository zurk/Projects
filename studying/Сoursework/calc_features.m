function [ features ] = calc_features( X )
%CALC_FEATURES Summary of this function goes here
%   Detailed explanation goes here

%X = D(curIndx,:);% 6,7,9,12,28,31,32,55
[~,F,T,P] = spectrogram(X,128,120,512,2000);
F = F(25:129); % Hz from 93.75 to 500
P = P(25:129,:);
P = 10 * log10(P);

FrBegin = 2;
FrEnd = 29;
FrBegin2 = 32;
FrEnd2 = 67;
hight = 10;

value = zeros(length(T), 2);
for tBegin = 1:length(T)-50
    tEnd = min(floor(tBegin + 0.5 /(T(2) - T(1))), length(T));
    mask = get_template([size(P,2), size(P,1)], [tBegin, FrBegin], [tEnd, FrEnd], hight)';
    Q = mask .* P;
    value(tBegin, 1) = sum(Q(:))/sum(mask(:));
end

[~, tBegin] = max(value(:,1));
tEnd = min(floor(tBegin + 0.5 /(T(2) - T(1))), length(T));
mask = get_template([size(P,2), size(P,1)], [tBegin, FrBegin], [tEnd, FrEnd], hight)';
Q = mask .* P;

features = [Q(mask == 1) ; tBegin];
if(length(features) < 1261)
    features = [features; zeros(1261 - length(features), 1)];
end

