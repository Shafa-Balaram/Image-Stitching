% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to compute the RANSAC algorithm using two sets of matched      %
% keypoints. The inliers are points located within a margin (distance) of %
% epsilon.                                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [Hfinal, inliers] = RANSAC(pts1, pts2, epsilon)

    % number of samples
    N = size(pts1, 2);

    % number of iterations
    Niters = 1000;

    % initialise arrays
    H = zeros(3, 3, Niters);
    inliers = zeros(Niters, N);
    Ninliers = zeros(Niters, 1);

    for n = 1 : Niters
        
        % randomly sample 4 pairs of keypoints
        sample_idxs = randperm(N, 4);
        pts1_selected = pts1(:, sample_idxs);
        pts2_selected = pts2(:, sample_idxs);  
        
        % calculate the homography matrix from these 4 pairs of keypoints
        H(:, :, n) = getHomographyMatrix(pts1_selected, pts2_selected);
    
        % project the keypoints from image 2 to image 1 
        pts1_hmg = [pts1(1, :); pts1(2, :); ones(1, size(pts1, 2))];
        proj_pts2 = H(:, :, n) * pts1_hmg ;
        proj_pts2 = proj_pts2(1:2, :) ./ proj_pts2(3, :);
    
        % offsets between the original and transformed keypoints in image 2
        dx = proj_pts2(1,:) - pts2(1,:);
        dy = proj_pts2(2,:) - pts2(2,:);
    
        % Euclidean distances
        dist = dx.^2 + dy.^2;
    
        % inliers are those located within the margin epsilon
        inliers(n, :) = dist < epsilon ;
  
        % number of inliers for this H
        Ninliers(n) = sum(inliers(n, :)) ;
    
    end

    % select the largest set of inliers and evaluate the final homography
    % matrix
    [~, idx] = max(Ninliers);
    inliers = inliers(idx, :);
    inliers = logical(inliers);
    Hfinal = getHomographyMatrix(pts1(:, inliers), pts2(:, inliers));
    
end

