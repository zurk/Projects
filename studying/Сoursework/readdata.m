Y = importdata('.\data\train.csv');
Y = Y.data;

D = [];
fprintf('      \n');
for i = 1:30000
    filename = ['.\data\train\train' int2str(i) '.aiff'];
    D(i,:) = aiffread(filename);
    fprintf('\b\b\b\b\b\b\b%5.2f%%\n', i/300);
end

[~,FS,NBITS,CHUNKDATA] = aiffread('.\data\train\train1.aiff');