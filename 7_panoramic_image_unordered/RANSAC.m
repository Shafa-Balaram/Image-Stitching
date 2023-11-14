% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to compute the RANSAC algorithm using two sets of matched      %
% keypoints. The inliers are points located within a margin (distance) of %
% epsilon.                                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [Hfinal, inliers] = RANSAC(image1, image2, ratio, epsilon)
    
    % obtain SIFT keypoints and descriptors using VLFeat
    greyscale_image1 = single(rgb2gray(image1)) ;
    greyscale_image2 = single(rgb2gray(image2)) ;
    [keypoints1, descriptors1] = vl_sift(greyscale_image1);
    [keypoints2, descriptors2] = vl_sift(greyscale_image2);
    keypoints1_loc = keypoints1(1:2, :);
    keypoints2_loc = keypoints2(1:2, :);
    
    % keypoint matching 
    [match_idxs] = getMatchedKeypoints(double(descriptors1), ...
                                double(descriptors2), ratio) ;
    pts1 = keypoints1_loc(:, match_idxs(1,:)) ; 
    pts2 = keypoints2_loc(:, match_idxs(2,:)) ; 
    
    % number of samples
    N = size(pts1, 2);

    % number of iterations
    Niters = 100;

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

