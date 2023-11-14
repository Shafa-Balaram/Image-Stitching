% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to generate Gaussian kernel of any specified odd kernel size   %
% and scale sigma.                                                        %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [kernel] = getGaussianKernel(kernel_size, sigma)

    % define the x and y axes coordinates
    x = [(1 - kernel_size) / 2 : (kernel_size - 1) / 2];
    y = x;

    % define a meshgrid of the 2D coordinates
    [X, Y] = meshgrid(x, y);

    % Gaussian filter 
    kernel = exp(- (X.^2 + Y.^2) ./ (2 * sigma^2));

    % normalise the kernel 
    kernel = kernel ./ sum(kernel(:));
    % f = f ./ (2 * pi * sigma^2);

end

