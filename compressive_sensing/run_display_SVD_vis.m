%% SVD components


%% graph display features
topK = 15;

subR = 5;
subC = 3;

%% figures

figure
for k=1:topK
    subplot( subR , subC , k );
    %plot(tt,V(:,k));
    plot(VX(:,k) * SX(k,k));
    title(int2str(k));
end
%suptitle('X');

figure
for k=1:topK
    subplot( subR , subC , k );
    %plot(tt,V(:,k));
    plot(VY(:,k) * SY(k,k));
    title(int2str(k));
end
%suptitle('Y');

figure
for k=1:topK
    subplot( subR , subC , k );
    %plot(tt,V(:,k));
    plot(VZ(:,k) * SZ(k,k));
    title(int2str(k));
end
%suptitle('Z');

%}