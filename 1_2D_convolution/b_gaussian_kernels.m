% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                         Part 1: 2D Convolution                          %
%                            Gaussian Kernels                             %
%                              Shafa Balaram                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


close all; clear all; clc;


%%% Step 0: Load the example greyscale image
%%% ----------------------------------------

image = imread('coins.png');
image = double(image) / 255;


%%% Step 1: 2D convolution with a Gaussian kernel 
%%% ---------------------------------------------

% set the kernel sizes and scales
kernel_sizes = [5, 15, 25];
sigmas = [0.1, 2, 5];

% effect of varying kernel sizes and scales
fig1 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 30 30])

plot_idx = 1;
for i = 1 : length(kernel_sizes)
    for j = 1 : length(sigmas)
        
        gauss_filter = getGaussianKernel(kernel_sizes(i), sigmas(j));
        gauss_img = Conv2D(gauss_filter, image);
        
        subplot(length(sigmas), length(kernel_sizes), plot_idx);
        imagesc(gauss_img); colormap('gray');
        
        if i == 1
            title(['$\sigma =\ $', num2str(sigmas(j))], ...
                   'fontsize', 22, 'interpreter', 'latex', 'fontweight', 'bold')
        end
        set(gca,'XTick',[]); set(gca,'YTick',[]);
        if j == 1
            ylabel(['$N =\ $', num2str(kernel_sizes(i)), '\ '], ...
                    'fontsize', 22, 'interpreter', 'latex')
            set(get(gca,'ylabel'), 'Rotation', 0, 'HorizontalAlignment',...
            'right', 'VerticalAlignment','middle')
        end
        plot_idx = plot_idx + 1;
        
    end
    
end

sgtitle('\bf{2D Convolution with Gaussian Kernels}', ...
        'fontsize', 22, 'interpreter', 'latex')

    
%% save figure
set(fig1, 'PaperSize',[30 20], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [30, 20], ...
          'DefaultFigurePosition', [1, 1, 29, 19])
print(fig1, 'part1_gaussian_output', '-dpdf', '-fillpage', '-r400')

