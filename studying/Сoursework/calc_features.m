function [ f1, f2 ] = calc_features( X )
%CALC_FEATURES Summary of this function goes here
%   Detailed explanation goes here

%X = D(curIndx,:);% 6,7,9,12,28,31,32,55
[~,F,T,P] = spectrogram(X,128,120,512,2000);
F = F(25:129); % Hz from 93.75 to 500
P = P(25:129,:);

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
    %tEnd = min(floor(tBegin + 0.2 /(T(2) - T(1))), length(T));
    %mask = get_template([size(P,2), size(P,1)], [tBegin, FrBegin2], [tEnd, FrEnd2], hight)';
    %Q = mask .* P;
    %value(tBegin, 2) = sum(Q(:))/sum(mask(:));
end

E = sum(value(:,1))/length(value(:,1));
f2 = sum(abs(diff(value(:,1))))/length(value(:,1));

[~, mF] = max(P,[], 1);
mF = F(1) + (F(2) - F(1)) * (mF - 1);
windowSize = 10;
Q = filter(ones(1,windowSize)/windowSize,1,medfilt1(mF,10));
Q = diff(Q) > 0;
k=0;
kmax = 0;
for i = 1:length(Q)
    if Q(i)
        k = k + 1;
    else if k > kmax
            kmax = k;
         end
         k=0;
    end
end
f1 = kmax;   
f1 = f1 + max(value(:,1)) / E;
end

