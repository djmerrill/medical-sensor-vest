% run SVD of sensor array data

%% data

select_time_start = 12500;
select_time_end = 16000; 

AZ = pZ(:,select_time_start:select_time_end);
AY = pY(:,select_time_start:select_time_end);
AX = pX(:,select_time_start:select_time_end);

for i=1:dim
   AX(i,:) = detrend( (  AX(i,:) ) , 3 ); 
   AY(i,:) = detrend( (  AY(i,:) ) , 3 ); 
   AZ(i,:) = detrend( (  AZ(i,:) ) , 3 ); 
end

%% SVD
K = 48;
[ UX , SX , VX ] = svds( AX , K );
[ UY , SY , VY ] = svds( AY , K );
[ UZ , SZ , VZ ] = svds( AZ , K );
