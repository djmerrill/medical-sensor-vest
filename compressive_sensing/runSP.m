% run signal processing on the data
% assume loading and LSB overflow is processed

%% stack the data
pX = [X0'; X1'; X2'; X3'; X4'; X5'; X6'; X7'];
pY = [Y0'; Y1'; Y2'; Y3'; Y4'; Y5'; Y6'; Y7'];
pZ = [Z0'; Z1'; Z2'; Z3'; Z4'; Z5'; Z6'; Z7'];

% pX, pY, pZ should have the same dimensions

[dim, ~] = size(pX);

duration = max(T)-T(1);

fs = floor( length(T) / duration );

%% select best data

start_time = 10;% second
end_time = 50;% second

select_duration = end_time - start_time ;
startT = fs * 1;
endT = startT + fs * 3;

pX = pX(:, start_time * fs : end_time * fs );
pY = pY(:, start_time * fs : end_time * fs );
pZ = pZ(:, start_time * fs : end_time * fs );

[sensor_number , data_number ] = size(pX);
time = linspace(0, select_duration , data_number );

%% filtering

[b,a] = butter(6, fc/ (fs/2) ,'low');

for i=1:dim
   pX(i,:) = detrend( filtfilt( b, a, pX(i,:) ) ); 
   pY(i,:) = detrend( filtfilt( b, a, pY(i,:) ) ); 
   pZ(i,:) = detrend( filtfilt( b, a, pZ(i,:) ) ); 
   
end

for i=1:dim
   pX(i,:) = detrend( (  pX(i,:) ) , 3 ); 
   pY(i,:) = detrend( (  pY(i,:) ) , 3 ); 
   pZ(i,:) = detrend( (  pZ(i,:) ) , 3 ); 
   
end

for i=1:dim
   pX(i,:) = smoothdata( (  pX(i,:) ) , 'gaussian' , floor(fs/20) ); 
   pY(i,:) = smoothdata( (  pY(i,:) ) , 'gaussian' , floor(fs/20) );  
   pZ(i,:) = smoothdata( (  pZ(i,:) ) , 'gaussian' , floor(fs/20) ); 
end
