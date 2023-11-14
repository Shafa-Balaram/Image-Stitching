% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to match two sets of keypoints. Using David Lowe's ratio test, %
% only closest distances < ratio*second closest distances are chosen as   %
% matches.                                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [matches] = getMatchedKeypoints(d1, d2, ratio)
    
    % array to save the indices of matched keypoints from the sets of
    % descriptors
    matches = [];

    % obtain the Euclidean distances / L2-norms between every pair of
    % descriptors
    D = getPairwiseDistance(d1, d2);
    
    % sort the distances to keypoints in image 2 in increasing order
    [Dsorted, I] = sort(D, 2);
    
    % distances to nearest and second nearest neighbours 
    closest_dist = Dsorted(:, 1);
    second_closest_dist = Dsorted(:, 2);
    
    % thresholded distance
    threshold_dist = ratio .* second_closest_dist;
    
    % save those matches where the second nearest distance is at least
    % threshold * distance to nearest neighbour
    for i = 1 : size(d1, 2)
        if  closest_dist(i) < threshold_dist(i) 
            matches = [matches; i, I(i, 1)];
        end        
    end
    matches = matches';

end

