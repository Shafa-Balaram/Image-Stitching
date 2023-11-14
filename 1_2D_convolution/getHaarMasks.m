% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to generate 5 Haar-like masks any specified kernel size.       %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [haar_mask1, haar_mask2, haar_mask3, haar_mask4, haar_mask5] = ...
    getHaarMasks(hsize)

    % initialise empty arrays for the masks
    haar_mask1 = ones(hsize, hsize);
    haar_mask2 = ones(hsize, hsize);
    haar_mask3 = ones(hsize, hsize);
    haar_mask4 = ones(hsize, hsize);
    haar_mask5 = ones(hsize, hsize);

    % Haar masks of type 1 for edge feature detection
    l = floor(hsize / 2);  % limit to define symmetry
    haar_mask1(:, 1:l) = -1; 
    haar_mask2(1:l, :) = -1;

    % Haar masks of type 2 for line feature detection
    l = floor(hsize / 3);  % limit to define symmetry
    haar_mask3(:, l+1:2*l) = -1; 
    haar_mask4(l+1:2*l, :) = -1; 

    % Haar masks of type 3 for 4-rectangle feature detection
    l = floor(hsize / 2);  % limit to define symmetry
    haar_mask5(1:l, 1:l) = -1;
    haar_mask5(l+1:end, l+1:end) = -1;

end

