function [ X , Y, Z ] = cleanNoise( X, Y, Z )

load('par2.mat');

[ t , N ] = size(X);

%% overflow

threshold = 15;

MX = median(X);
MY = median(Y);
MZ = median(Z);

for i=1:N
   if MX(i) < threshold
      id = find( X(:,i) < 2 * threshold );
      X(id,i) = X(id,i) + 256;
      MX(i) = MX(i) + 256;
   end
end

for i=1:N
   if MY(i) < threshold
      id = find( Y(:,i) < 2 * threshold );
      Y(id,i) = Y(id,i) + 256;
      MY(i) = MY(i) + 256;
   end
end

for i=1:N
   if MZ(i) < threshold
      id = find( Z(:,i) < 2 * threshold );
      Z(id,i) = Z(id,i) + 256;
      MZ(i) = MZ(i) + 256;
   end
end


%% noise cleaning

fX = zeros(size(X));
fY = zeros(size(Y));
fZ = zeros(size(Z));

% data noise

for i=1:N 
   fX(:,i) = fft( X(:,i)  * 2 );
   X(:,i) = ifft( fX(:,i) * 1/2 );
end

for i=1:N
   fY(:,i) = fft( Y(:,i)  * 2 );
   Y(:,i) = ifft( fY(:,i) * 1/2 );
end

for i=1:N
   fZ(:,i) = fft( Z(:,i)  * 2 );
   Z(:,i) = ifft( fZ(:,i) * 1/2 );
end


for i=1:N
   id = find( abs( X(:,i) - MX(i) ) > threshold  );
   if ~isempty(id)
    X(id,i) = NaN;
    X(:,i) = fillmissing( X(:,i) , 'previous' );
   end 
end

for i=1:N
   id = find( abs( Y(:,i) - MY(i) ) > threshold  );
   if ~isempty(id)
    Y(id,i) = NaN;
    Y(:,i) = fillmissing( Y(:,i) , 'previous' );
   end 
end

for i=1:N
   id = find( abs( Z(:,i) - MZ(i) ) > threshold  );
   if ~isempty(id)
    Z(id,i) = NaN;
    Z(:,i) = fillmissing( Z(:,i) , 'previous' );
   end 
end


end