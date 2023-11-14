% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to obtain the projected corners of the original input image    %
% after the transformation with homography matrix H. It also returns the  %
% limits of the transformed image according to the original coordinates.  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [transformed_corners, transformed_limits] = getTransformedCorners(image, H)

    % dimensions of original image
    [rows, cols, ~] = size(image);
    
    % homogeneous coordinates of the original image's 4 corners in [x, y, 1]
    % order: top left, top right, bottom left, bottom right
    corners = [[1; 1; 1], [cols; 1; 1], [1; rows; 1], [cols; rows; 1]];
    
    % transform the corner coordinates using the homography matrix
    H_corners = H * corners;
    
    % obtain transformed corner coordinates in cartesian form
    transformed_corners = H_corners(1:2, :) ./ H_corners(3, :);
    
    % obtain the limits of the transformed image in terms of the reference
    row_min = min(transformed_corners(2, :));
    row_max = max(transformed_corners(2, :));
    col_min = min(transformed_corners(1, :));
    col_max = max(transformed_corners(1, :));
    transformed_limits = [row_min, row_max, col_min, col_max];    
    
end

