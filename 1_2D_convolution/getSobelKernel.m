% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to generate Sobel kernels of any specified odd kernel size to  %
% detect edges in x and y directions.                                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [kernel_x, kernel_y] = getSobelKernel(kernel_size)
    
    % kernel size should be odd
    assert(mod(kernel_size, 2) == 1)
    
    % number of iterations to obtain specified size 
    iters = (kernel_size + 1) * 0.5 + 1;
    
    %%% x-direction
    
    % 3x3 mask
    row1 = [1 2 1];
    row1_copy = row1;
    row2 = [1 0 -1];
    
    % augment the 3x3 mask 
    for i = 1 : iters - 3
        row1 = Conv1D(row1, row1_copy);
        row2 = Conv1D(row2, row1_copy);
    end
    
    % final mask
    kernel_x = row1' * row2;
        
    %%% y-direction
    kernel_y = kernel_x';

end

