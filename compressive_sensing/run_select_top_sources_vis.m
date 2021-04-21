
%% load data

load('sourceX_48comp_v4.mat');
load('sourceY_48comp_v4.mat');
load('sourceZ_48comp_v4.mat');

%% select top sources

% uncomment the targeted one

%top_time_source = zeros( size(time_source_x) ) ; time_source = time_source_x;
%top_time_source = zeros( size(time_source_y) ) ; time_source = time_source_y;
top_time_source = zeros( size(time_source_Z) ) ; time_source = time_source_Z;

[ source_number , ~ ] = size( top_time_source );

%% compute L2 norm

source_magnitude_L2 = zeros( source_number , 1 ); 

for i=1:source_number
    
    source_magnitude_L2(i) = norm( time_source(i,:) , 2 ); 

end
%% select top K sources
K = 48;

[ maxk_mag , idx ] = maxk( source_magnitude_L2 , K );

idx = idx';

for k=idx
   top_time_source(k,:) = time_source(k,:); 
end

figure
stem(maxk_mag);
title('Magnitude Rank');