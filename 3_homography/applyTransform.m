% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to transform the input image using the homography matrix H.    %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [transformed_image] = applyTransform(image, H)

    % obtain the limits of the transformed image as integer values
    [~, transformed_limits] = getTransformedCorners(image, H);
    row_min = floor(transformed_limits(1)); 
    row_max = ceil(transformed_limits(2));
    col_min = floor(transformed_limits(3)); 
    col_max = ceil(transformed_limits(4));
    
    % dimensions of the canvas for the transformed image
    Nrows = row_max - row_min + 1;
    Ncols = col_max - col_min + 1;
    
    % create a regular meshgrid for the canvas 
    [X, Y] = meshgrid(col_min:col_max, row_min:row_max);
    
    % obtain the canvas coordinates in cartesian and homogeneous forms
    canvas_coords = [X(:), Y(:)];
    canvas_coords_hmg = [X(:), Y(:), ones(size(canvas_coords, 1), 1)]';
    
    % apply the inverse of the homogeneous matrix to map transformed image 2 
    % to image 1 
    mapped_coords_hmg = inv(H) * canvas_coords_hmg;
    mapped_coords = mapped_coords_hmg(1:2, :) ./ mapped_coords_hmg(3, :);
    
    % reshape into the meshgrid shape
    cols_mapped = reshape(mapped_coords(1, :), Nrows, Ncols);
    rows_mapped = reshape(mapped_coords(2, :), Nrows, Ncols);
    
    % find the intensities of the image at these new locations using 
    % bilinear interpolation for each colour channel
    % assign 0 to values located outside the original image 
    transformed_image = zeros(Nrows, Ncols, size(image, 3));
    for c = 1 : 3
        transformed_image(:, :, c) = interp2(image(:, :, c), ...
                                             cols_mapped, ...
                                             rows_mapped, ...
                                             'linear', 0);
    end
    
end

