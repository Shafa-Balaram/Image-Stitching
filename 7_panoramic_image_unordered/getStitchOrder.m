% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to sort the sequence in which to stitch unordered images into  %
% a panorama. Method is based on the number of matched inliers.           %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [order, ref] = getStitchOrder(images, ratio, epsilon)
    
    % number of images
    N = length(images);
    
    % Number of inliers for every pair
    M = zeros(N, N);
    for i = 1 : N
        for j = 1 : N
            if i ~= j
                [~, inliers] = RANSAC(images{i}, images{j}, ratio, epsilon);                
                M(i, j) = sum(inliers);
            end
        end
    end
    
    % total number of inliers into and out of each image
    M_sum_out = sum(M, 2);
    M_sum_in = sum(M, 1);
    
    % reference image in the middle
    [~, ref] = max(M_sum_out);

    % sort the number of inliers into and out of images
    [M_sorted_out, I_sorted_out] = sort(M, 2, 'descend');
    [M_sorted_in, I_sorted_in] = sort(M, 1, 'descend');

    % border images are those with the fewest number of inliers
    [~, idxs] = sort(M_sorted_out(:, 1), 'ascend');
    border_idxs = idxs(1:2);
    
    % pairs from left to right (in) and from right to left (out)
    pairs_in = [[1:5]', I_sorted_out(:, 1)];
    pairs_out = [[1:5]', I_sorted_in(1, :)'];

    % adjacency matrix 
    A = zeros(N, N);
    for i = 1 : N
        A(pairs_in(i, 1), pairs_in(i, 2)) = 1;
        A(pairs_out(i, 2), pairs_in(i, 1)) = 1;      
    end
    
    % sequence 1
    order1 = zeros(1, 5); order1(1) = border_idxs(1);
    for i = 2 : N
        current_row = order1(i-1);
        temp_idx = find(A(current_row, :) == 1);
        if length(temp_idx) > 1
            is_pair = ~ismember(temp_idx, order1);
            order1(i) = temp_idx(is_pair);
        else
            assert(~ismember(temp_idx, order1));
            order1(i) = temp_idx;
        end
        current_row = order1(i);
    end
    
    % sequence 2
    order2 = zeros(1, 5); order2(1) = border_idxs(2);
    for i = 2 : 5
        current_row = order2(i-1);
        temp_idx = find(A(current_row, :) == 1);    
        if length(temp_idx) > 1
            is_pair = ~ismember(temp_idx, order2);
            valid = temp_idx(is_pair);
            order2(i) = valid(1);
        else
            assert(~ismember(temp_idx, order2));
            order2(i) = temp_idx;
        end
        current_row = order2(i);
    end
    
    % the sequences should be a flipped version of each other
    assert(sum(order1 - fliplr(order2)) == 0)
    
    % check the total number of outliers
    total_inliers1 = 0; total_inliers2 = 0;
    for i = 1 : N-1
        total_inliers1 = total_inliers1 + M(order1(i), order1(i+1));
        total_inliers2 = total_inliers2 + M(order2(i), order2(i+1));    
    end
    
    % choose the sequence with the largest number of inliers
    if total_inliers1 > total_inliers2
        order = order1; 
    else
        order = order2;
    end
    
end


