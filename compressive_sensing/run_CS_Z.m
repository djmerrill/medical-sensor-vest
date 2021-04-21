% run X compressive sensing

Gt = UZ' * G; 

%% sources

cvx_clear;
m = size(Gt,2); n = size(VZ,1); 
Vt = ( SZ * VZ' );

%% each time

time_source = zeros( m , n );
multi_time_sourceZ = zeros( m , n , 100) ; 

for i=1:10
    alpha = alpha_vector(i);
    for j=1:10
        beta = beta_vector(j);
        time_source = zeros( m , n );

for t=3:n       

Vs = Vt(:,t);

cvx_begin
    variable s(m)
    minimize( alpha * norm( s , 1 ) + (Gt*s-Vs)' * (Gt*s - Vs)  + beta * norm( s - 2 * time_source(:,t-1) + time_source(:,t-2) , 2) ) % smoothing
cvx_end

time_source(:,t) = s;

end
multi_time_sourceZ(:,:,10*(i-1)+j) = time_source;

    end
    
end