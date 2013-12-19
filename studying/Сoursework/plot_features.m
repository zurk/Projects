global D;
indx = 150:20150;
fprintf('                     \n');
F = zeros(length(indx), 381);
tic;
p=0;
for i = indx
     F(i-indx(1)+ 1,:) = calc_features(D(i,:));
     p = (i-indx(1)+1)/length(indx);
     t = toc;
     fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b%5.2f%%\n time:%5.2fmin ', 100 * p, (t/p-t)/60 );  
end
toc;

indx = 1:54503;
fprintf('                     \n');
Ftest = zeros(length(indx), 381);
tic;
p=0;
for i = indx
     Ftest(i-indx(1)+ 1,:) = calc_features(Dtest(i,:));
     p = (i-indx(1)+1)/length(indx);
     t = toc;
     fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b%5.2f%%\n time:%5.2fmin ', 100 * p, (t/p-t)/60 );  
end
toc;


% 
% labels = [0,1];
% hold on;
% grid on;
% for i = 1:length(labels)
%     scatter(F(Y(indx) == labels(i), 4), F(Y(indx) == labels(i), 2), 'x','LineWidth',1.5);
% end
% 
% legend('No whale', 'whale');
% xlabel('curve max / curve mean');
% ylabel('sum(abs(diff(value(:,1))))/length(value(:,1))');
