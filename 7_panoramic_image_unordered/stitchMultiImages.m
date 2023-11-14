% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to stitch multiple ordered images into a panoramam starting    %
% with the reference image.                                               %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [panorama] = stitchMultiImages(images, ref, ratio, epsilon)

    % number of ordered images
    N = length(images);
    
    % start from reference to the left 
    panorama_left = images{1};
    if ref > 1
        for n = 2 : ref
            [H, ~] = RANSAC(panorama_left, images{n}, ratio, epsilon);
            if abs(det(H)) > 1e-15
                panorama_left = stitchImagePair(images{n}, panorama_left, inv(H));
            end
        end
    end
%     figure;imshow(panorama_left)
    
    % start from reference to the right
    if ref ~= N
        panorama_right = images{ref+1};
    
        if ref < N-1
            for n = ref + 2 : N
                [H, ~] = RANSAC(panorama_right, images{n}, ratio, epsilon);
                if abs(det(H)) > 1e-15
                    panorama_right = stitchImagePair(panorama_right, images{n}, H);
                else
                    fprintf(['Image ', num2str(n), ' excluded! \n'])
                end
            end
        end
%         figure;imshow(panorama_right)
    end 
    
    % stitch the left and right panoramas
    panorama = panorama_left;
    if ref ~= N
        [H, ~] = RANSAC(panorama, panorama_right, ratio, epsilon);
        panorama = stitchImagePair(panorama, panorama_right, H);
%         figure;imshow(panorama)
    end
end

