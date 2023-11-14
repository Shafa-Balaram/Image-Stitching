% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to calculate the homography matrix using two sets of matched   %
% points and the SVD method.                                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [H] = getHomographyMatrix(X, Xprime)
    
    % number of points
    N = size(X, 2);

    % matrix A
    A = zeros(N*2, 9);
    for i = 1 : N
        Asingle = ...
            [X(1,i), X(2,i), 1, 0, 0, 0, ...
             -Xprime(1,i)*X(1,i), -Xprime(1,i)*X(2,i), -Xprime(1,i); ...
             0, 0, 0, X(1,i), X(2,i), 1, ...
             -Xprime(2,i)*X(1,i), -Xprime(2,i)*X(2,i), -Xprime(2,i)];
        A((i*2)-1 : (i*2), :) = Asingle;
    end

    % singular value decomposition 
    [~, ~, V] = svd(A);

    % recover the homography matrix
    h = V(:, end);
    H = (reshape(h, 3, 3))';
    
end

