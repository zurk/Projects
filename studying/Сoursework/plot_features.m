global D;
indx = 1:2000;
fprintf('      \n');
X = zeros(length(indx), 1261);
for i = indx
    X(i,:) = calc_features(D(i,:));
     fprintf('\b\b\b\b\b\b\b%5.2f%%\n', 100 * i/length(indx));
end
F = fast_tsne(X);
 
labels = [0,1];
hold on; 
grid on;
for i = 1:length(labels)
    scatter(F(Y(indx) == labels(i), 1), F(Y(indx) == labels(i), 2), 'x','LineWidth',1.5);
end

% 
% legend('No whale', 'whale');
% xlabel('');
% ylabel('sum(abs(diff(value(:,1))))/length(value(:,1))');
% xlabel('[~, mF] = max(P,[], 1);mF = F(1) + (F(2) - F(1)) * (mF - 1);Q = filter(ones(1,10)/10,1,medfilt1(mF,10)) + max / mean;');