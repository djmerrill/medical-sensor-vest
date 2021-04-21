
close all;

%% load data

sensor_number = 6; % 6 in a row
D0 = importdata( '0_data.txt' );
D1 = importdata( '1_data.txt' );
D2 = importdata( '2_data.txt' );
D3 = importdata( '3_data.txt' );
D4 = importdata( '4_data.txt' );
D5 = importdata( '5_data.txt' );
D6 = importdata( '6_data.txt' );
D7 = importdata( '7_data.txt' );


%% problematic head lines removal
D0( [1,2] , : ) = [];
D1( [1,2] , : ) = [];
D2( [1,2] , : ) = [];
D3( [1,2] , : ) = [];
D4( [1,2] , : ) = [];
D5( [1,2] , : ) = [];
D6( [1,2] , : ) = [];
D7( [1,2] , : ) = [];

%% problematic columns removal
D0 = D0(:,1:18);
D1 = D1(:,1:18);
D2 = D2(:,1:18);
D3 = D3(:,1:18);
D4 = D4(:,1:18);
D5 = D5(:,1:18);
D6 = D6(:,1:18);
D7 = D7(:,1:18);


%% chop to the same time length
[r0,~] = size(D0);
[r1,~] = size(D1);
[r2,~] = size(D2);
[r3,~] = size(D3);
[r4,~] = size(D4);
[r5,~] = size(D5);
[r6,~] = size(D6);
[r7,~] = size(D7);

time_point = floor( min([r0,r1,r2,r3,r4,r5,r6,r7]) / 2 );

[ X0, Y0, Z0, T0 ] = buildDmatrix(D0, time_point, sensor_number);
[ X1, Y1, Z1, T1 ] = buildDmatrix(D1, time_point, sensor_number);
[ X2, Y2, Z2, T2 ] = buildDmatrix(D2, time_point, sensor_number);
[ X3, Y3, Z3, T3 ] = buildDmatrix(D3, time_point, sensor_number);
[ X4, Y4, Z4, T4 ] = buildDmatrix(D4, time_point, sensor_number);
[ X5, Y5, Z5, T5 ] = buildDmatrix(D5, time_point, sensor_number);
[ X6, Y6, Z6, T6 ] = buildDmatrix(D6, time_point, sensor_number);
[ X7, Y7, Z7, T7 ] = buildDmatrix(D7, time_point, sensor_number);

T = min( [ length(T0) , length(T1) , length(T2) , length(T3) , length(T4) ,length(T5) , length(T6) , length(T7)  ] );
[ X0, Y0, Z0, T0 ] = getLength(X0, Y0, Z0, T0, T);
[ X1, Y1, Z1, T1 ] = getLength(X1, Y1, Z1, T1, T);
[ X2, Y2, Z2, T2 ] = getLength(X2, Y2, Z2, T2, T);
[ X3, Y3, Z3, T3 ] = getLength(X3, Y3, Z3, T3, T);
[ X4, Y4, Z4, T4 ] = getLength(X4, Y4, Z4, T4, T);
[ X5, Y5, Z5, T5 ] = getLength(X5, Y5, Z5, T5, T);
[ X6, Y6, Z6, T6 ] = getLength(X6, Y6, Z6, T6, T);
[ X7, Y7, Z7, T7 ] = getLength(X7, Y7, Z7, T7, T);

T = T0;
clear T0 T1 T2 T3 T4 T5 T6 T7;

%% raw data plots
figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( X0(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( X1(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( X2(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( X3(:,k) );
    
end

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( X4(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( X5(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( X6(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( X7(:,k) );
    
end

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( Y0(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( Y1(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( Y2(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( Y3(:,k) );
    
end

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( Y4(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( Y5(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( Y6(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( Y7(:,k) );
    
end

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( Z0(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( Z1(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( Z2(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( Z3(:,k) );
    
end

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( Z4(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( Z5(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( Z6(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( Z7(:,k) );
    
end

%% clean data noise

[ X0 , Y0, Z0 ] = cleanNoise( X0, Y0, Z0 );
[ X1 , Y1, Z1 ] = cleanNoise( X1, Y1, Z1 );
[ X2 , Y2, Z2 ] = cleanNoise( X2, Y2, Z2);
[ X3 , Y3, Z3 ] = cleanNoise( X3, Y3, Z3 );
[ X4 , Y4, Z4 ] = cleanNoise( X4, Y4, Z4 );
[ X5 , Y5, Z5 ] = cleanNoise( X5, Y5, Z5 );
[ X6 , Y6, Z6 ] = cleanNoise( X6, Y6, Z6 );
[ X7 , Y7, Z7 ] = cleanNoise( X7, Y7, Z7 );

% X

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( X0(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( X1(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( X2(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( X3(:,k) );
    
end

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( X4(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( X5(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( X6(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( X7(:,k) );
    
end

% Y

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( Y0(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( Y1(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( Y2(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( Y3(:,k) );
    
end

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( Y4(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( Y5(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( Y6(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( Y7(:,k) );
    
end


% Z
figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( Z0(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( Z1(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( Z2(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( Z3(:,k) );
    
end

figure
for k=1:sensor_number
    subplot(4, sensor_number, k ); 
    plot( Z4(:,k) );
    subplot(4, sensor_number, sensor_number + k ); 
    plot( Z5(:,k) );
    subplot(4, sensor_number, sensor_number*2 + k ); 
    plot( Z6(:,k) );
    subplot(4, sensor_number, sensor_number*3 + k ); 
    plot( Z7(:,k) );   
end
