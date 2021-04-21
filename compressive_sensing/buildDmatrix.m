function [ X, Y, Z, T ] = buildDmatrix( D, time_point, N)

A = zeros(time_point, 3*N);
X = zeros(time_point , N);
Y = zeros(time_point , N);
Z = zeros(time_point , N);
T = zeros(time_point, 1);

[ L ] = size(D);

%%  
pivot = 1;
for k=1:L
    if pivot > time_point
        break;
    end
    if sum( ~isnan( D(k,:) ) ) == (3*N)
        A(pivot,:) = D(k,:);
    elseif sum( ~isnan( D(k,:) ) ) == 1
        T(pivot) = D(k,1);
        pivot = pivot + 1;
    else
        continue;
    end
    
end

%% assign  values to X, Y, Z
for i=1:N
   
    X(:,i) = A(:,3*(i-1) + 1);
    Y(:,i) = A(:,3*(i-1) + 2);
    Z(:,i) = A(:,3*(i-1) + 3);
    
end

id = find(T==0);
T(id) = [];
X(id,:) = [];
Y(id,:) = [];
Z(id,:) = [];

end