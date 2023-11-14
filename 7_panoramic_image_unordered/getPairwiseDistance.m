% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to calculate the Euclidean distance between two sets of        %
% coordinates.  For faster computation,                                   %               
% D = (X-Y)' * (X-Y) = dot(X,X) + dot(Y,Y) - 2 dot(X,Y)                   %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [D] = getPairwiseDistance(X, Y)
    
    % number of samples 
    NX = size(X, 2); 
    NY = size(Y, 2);
    
    % initialise an empty array 
    D = zeros(NX, NY);
    
    % calculate the Euclidean distances 
    Xsquared = reshape(sum(X .* X, 1), NX, 1) * ones(1, NY);
    Ysquared = ones(NX, 1) * sum(Y .* Y, 1);
    Dsquared =  Xsquared + Ysquared - (2 * (X' * Y));
    D = sqrt(Dsquared);

%     for i = 1 : NX
%         Z = Y - X(:, i);
%         D(i, :) = sqrt(Z * Z');
%     end
%     
end

