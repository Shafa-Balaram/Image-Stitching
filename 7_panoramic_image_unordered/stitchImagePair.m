% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to stitch two images into a mosaic using homography matrix.    %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [mosaic] = stitchImagePair(image1, image2, H)
    % assume image 1 is the reference image 
    
    % dimensions of images 
    [Nrows1, Ncols1, Nchannels] = size(image1);
    [Nrows2, Ncols2, ~] = size(image2);
    
    % corner coordinates of image 2 in homogeneous format
    corners = [[1; 1], [Ncols2; 1], [Ncols2; Nrows2], [1; Nrows2]];
    corners(3, :) = 1;
    
    % transform the corners of image 2 using the inverse of homography matrix 
    proj_corners = pinv(H) * corners ;        
    proj_corners = proj_corners(1:2, :) ./ proj_corners(3, :);
    
    % limits of transformed image 2 with reference to original coordinates
    x1 = min([1, proj_corners(1, :)]) : max([Ncols1, proj_corners(1,:)]) ;
    y1 = min([1, proj_corners(2, :)]) : max([Nrows1, proj_corners(2,:)]) ;

    % regular meshgrid of coordinates to contain transformed image 2
    [X, Y] = meshgrid(x1, y1) ;
    
    % interpolate the intensities of image 1 at the locations of the
    % regular meshgrid with bilinear interpolation for each colour channel
    % values located outside the original image are assigned NaN values
    proj_image1 = zeros(length(y1), length(x1), size(image1, 3));
    for c = 1 : 3
        proj_image1(:, :, c) = interp2(image1(:, :, c), X, Y, 'linear');
    end
    
    % find the intensities of image 2 at the transformed locations using 
    % bilinear interpolation for each colour channel
    % values located outside the original image are assigned NaN values
    coords2 = [X(:)'; Y(:)'];
    coords2 = [coords2; ones(1, size(coords2, 2))];
    proj_coords2 = H * coords2;
    proj_coords2 = proj_coords2(1:2, :) ./ proj_coords2(3, :);
    proj_x2 = reshape(proj_coords2(1, :), size(X));
    proj_y2 = reshape(proj_coords2(2, :), size(Y));
    proj_image2 = zeros(size(proj_y2, 1), size(proj_y2, 2), Nchannels);
    for c = 1 : 3
        proj_image2(:, :, c) = interp2(image2(:, :, c), proj_x2, proj_y2, 'linear');
    end
    
    % set NaN elements to 0 in each image
    images_sum = ~isnan(proj_image1) + ~isnan(proj_image2);
    proj_image1(isnan(proj_image1)) = 0 ;
    proj_image2(isnan(proj_image2)) = 0;
    mosaic = (proj_image1 + proj_image2) ./ images_sum ;
   
end