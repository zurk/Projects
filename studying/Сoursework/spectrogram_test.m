global i;
global D;
global Y;
Y = importdata('.\data\train.csv');
Y = Y.data;
i = 6;
set(gcf,'keypressFcn',@(x,y)catchKey(x,y));
plot_spect(D(i,:));