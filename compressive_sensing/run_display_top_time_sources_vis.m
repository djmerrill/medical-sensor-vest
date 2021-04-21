% display the time sources

close all;

%% whole
figure
plot(top_time_source');

%% tensor construction first
nV = 20; nH = 15; n = 3501;

tensor_source = zeros( nV , nH , n );

for t=1:n
   tensor_source(:,:,t) = reshape( top_time_source(:,t) ,nV , nH ); 
end


%%
factor = 0.2;
ymin = -5e-1 * factor;
ymax = 5e-1 * factor;

scale = 1e0;

tn = n;

for k=1:5
   figure 
   for i=1:60 
       
   subplot(4,15,i);
   
   if mod(i,15) == 0
        vec = reshape( tensor_source( 4*(k-1) + 1 + floor((i-1)/15) , 15 , :) , [ 1 , n  ]  );
   else
        vec = reshape( tensor_source( 4*(k-1) + 1 + floor((i-1)/15) , mod(i,15) , :)  , [ 1 , n  ]  );
   end
   
   plot( vec * scale );
   axis([0 tn ymin ymax]);
   
   end

end


%% top components, graphs can be adjusted
figure
subR = 12;
subC = 4;
topK = K;

for k=1:topK
    subplot( subR , subC , k );
    %plot(tt,V(:,k));
    plot( top_time_source(idx(k),:) );
    title(int2str(idx(k)));
end
suptitle('top sources Z');








