% visualize the sources

new_time_source = time_source ;

%% animation

picT = 3501;

figure
set(gcf, 'Position', [100 ,100, 800, 800]);

myVideo = VideoWriter('stand_rest_Z_48_opt_v4'); %open video file
myVideo.FrameRate = 120;  %can be adjusted

open(myVideo);

for j=1:1:picT       
       
       colormap(jet);
       
       p1 = imagesc( reshape( new_time_source(:,j) , [ nV , nH ] ) );
       
       
       
       caxis([-0.25 0.25]); % adjustable for different dimensional accelerations
       
       pause(0.01);
       hold on;
       
       frame = getframe(gcf); %get frame
       writeVideo(myVideo, frame);
       
       if(j~=picT )
            delete(p1);
       end
       
     
end

close(myVideo);
