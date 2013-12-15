global D;
indx = [1:4000];
fprintf('      \n');
F = zeros(length(indx), 2);
for i = indx
    [F(i,1), F(i,2)] = calc_features(D(i,:));
     fprintf('\b\b\b\b\b\b\b%5.2f%%\n', 100 * i/length(indx));
end

labels = [0,1];
hold on;
grid on;
for i = 1:length(labels)
    scatter(F(Y(indx) == labels(i), 1), F(Y(indx) == labels(i), 2), 'x','LineWidth',1.5);
end

legend('No whale', 'whale');
xlabel('curve max / curve mean');
ylabel('sum(abs(diff(value(:,1))))/length(value(:,1))');
