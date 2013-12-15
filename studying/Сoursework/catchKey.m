function catchKey(varargin)
global i;
global D;
global Y;
switch varargin{2}.Key
    case {'1', '+', 'rightarrow'}
        i = i + 1;
    case {'2', '-', 'leftarrow'}
        i = i - 1;
    otherwise
        %pass other keypresss through
end
    plot_spect(D(i,:));
    title(sprintf('индекс: %d ответ: %d',i, Y(i)));
end