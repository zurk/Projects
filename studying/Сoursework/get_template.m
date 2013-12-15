function [ X ] = get_template( size, beginp, endp, height )
%GET_TEMPLATE Summary of this function goes here
%   Detailed explanation goes here

X = zeros(size);
y_max = size(2);
dx = (endp(1) - beginp(1));
dy = (endp(2) - beginp(2));
k = dy / dx;
for x = beginp(1):endp(1)
    y = floor( beginp(2) + k * (x - beginp(1)));
    X(x, max(y, 0):min(y+height-1, y_max)) = 1;
end
end
