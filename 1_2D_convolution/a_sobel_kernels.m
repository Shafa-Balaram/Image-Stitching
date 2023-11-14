% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                         Part 1: 2D Convolution                          %
%                              Sobel Kernels                              %
%                              Shafa Balaram                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;


%%% Step 0: Load the example greyscale image
%%% ----------------------------------------

image = imread('coins.png');
image = double(image) / 255;

% visualise 
fig1 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 11 10])
imagesc(image); axis off; colormap(gray);
title('\bf{coins.png}', 'fontsize', 22, 'interpreter', 'latex')

      
%%% Step 1: 2D convolution with a Sobel kernel 
%%% ------------------------------------------

% kernel sizes
ksizes = [3, 7, 11];

% visualise 
fig2 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 35 25])

% horizontal and vertical edge detection
for i = 1 : length(ksizes)
    
    [kernel_x, kernel_y] = getSobelKernel(ksizes(i));
    sobel_image_x = Conv2D(kernel_x, image);
    sobel_image_y = Conv2D(kernel_y, image);
    sobel_mag = sqrt((sobel_image_x.^2) + (sobel_image_y.^2));
    ksize_x = size(kernel_x, 1);
    ksize_y = size(kernel_x, 2);
    
    subplot(3, 3, i);
    imagesc(sobel_image_x); colormap('gray'); 
    set(gca,'XTick',[]); set(gca,'YTick',[]);
    if i == 1
        ylabel('$\mathbf{G}_x\ $', 'fontsize', 22, 'interpreter', 'latex')
        set(get(gca,'ylabel'), 'Rotation', 0, 'HorizontalAlignment',...
            'right', 'VerticalAlignment','middle')
    end
    
    title(['${N =\ }$', num2str(ksize_x)], 'fontsize', 22, ...
          'interpreter', 'latex')
    
    subplot(3, 3, i+length(ksizes));
    imagesc(sobel_image_y); colormap('gray'); 
    set(gca,'XTick',[]); set(gca,'YTick',[]);
    if i == 1
        ylabel('$\mathbf{G}_y\ $', 'fontsize', 22, 'interpreter', 'latex')
        set(get(gca,'ylabel'), 'Rotation', 0, 'HorizontalAlignment',...
            'right', 'VerticalAlignment','middle')
    end
    
    subplot(3, 3, i+length(ksizes)*2);
    imagesc(sobel_mag); colormap('gray'); 
    set(gca,'XTick',[]); set(gca,'YTick',[]);
    if i == 1
        ylabel('$\sqrt{\mathbf{G}_x^2 + \mathbf{G}_y^2 \ }$', 'fontsize', 22, 'interpreter', 'latex')
        set(get(gca,'ylabel'), 'Rotation', 0, 'HorizontalAlignment',...
            'right', 'VerticalAlignment','middle')
    end
   
end

sgtitle('\bf{2D Convolution with Sobel Kernels}', ...
        'fontsize', 22, 'interpreter', 'latex')

    
%% save figure
set(fig1, 'PaperSize',[11 10], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [11, 10], ...
          'DefaultFigurePosition', [1, 1, 10, 9])
print(fig1, 'part1_coins', '-dpdf', '-fillpage', '-r400')

set(fig2, 'PaperSize',[35 25], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [35, 25], ...
          'DefaultFigurePosition', [1, 1, 34, 24])
print(fig2, 'part1_sobel_output', '-dpdf', '-fillpage', '-r400')

