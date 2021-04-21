function [ X0, Y0, Z0, T0 ] = getLength(X0, Y0, Z0, T0, T)
X0 = X0(1:T,:);
Y0 = Y0(1:T,:);
Z0 = Z0(1:T,:);
T0 = T0(1:T,:);
end