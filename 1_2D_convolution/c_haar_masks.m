% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                         Part 1: 2D Convolution                          %
%                             Haar-like Masks                             %
%                              Shafa Balaram                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;


%%% Step 0: Load the example greyscale image
%%% ----------------------------------------

image = imread('coins.png');
image = double(image) / 255;


%%% Step 1: 2D convolution with 5 Haar-like masks
%%% ---------------------------------------------


% visualise the kernels 
kernel_size = 6;
[haar_mask1, haar_mask2, haar_mask3, haar_mask4, haar_mask5] = ...
    getHaarMasks(kernel_size);

haar_img1 = Conv2D(haar_mask1, image);
haar_img2 = Conv2D(haar_mask2, image);
haar_img3 = Conv2D(haar_mask3, image);
haar_img4 = Conv2D(haar_mask4, image);
haar_img5 = Conv2D(haar_mask5, image);
    
fig1 = figure('Color', [1,1,1]);
set(gcf,'units','centimeters','Position',[1 1 40 7])

subplot(1, 5, 1); imagesc(haar_mask1);
set(gca,'XTick',[]); set(gca,'YTick',[]);
title('\bf{Haar Mask 1}', 'fontsize', 22, 'interpreter', 'latex')
subplot(1, 5, 2); imagesc(haar_mask2);
set(gca,'XTick',[]); set(gca,'YTick',[]);
title('\bf{Haar Mask 2}', 'fontsize', 22, 'interpreter', 'latex')
subplot(1, 5, 3); imagesc(haar_mask3);
set(gca,'XTick',[]); set(gca,'YTick',[]);
title('\bf{Haar Mask 3}', 'fontsize', 22, 'interpreter', 'latex')
subplot(1, 5, 4); imagesc(haar_mask4);
set(gca,'XTick',[]); set(gca,'YTick',[]);
title('\bf{Haar Mask 4}', 'fontsize', 22, 'interpreter', 'latex')
subplot(1, 5, 5); imagesc(haar_mask5);
set(gca,'XTick',[]); set(gca,'YTick',[]);
title('\bf{Haar Mask 5}', 'fontsize', 22, 'interpreter', 'latex')
colormap(gray);

% visualise the convolution outputs

fig2 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 40 20])

row = 1;
for kernel_size = [6, 12, 24]
    
    [haar_mask1, haar_mask2, haar_mask3, haar_mask4, haar_mask5] = ...
        getHaarMasks(kernel_size);
    
    haar_img1 = Conv2D(haar_mask1, image);
    haar_img2 = Conv2D(haar_mask2, image);
    haar_img3 = Conv2D(haar_mask3, image);
    haar_img4 = Conv2D(haar_mask4, image);
    haar_img5 = Conv2D(haar_mask5, image);
    
    subplot(3, 5, (row-1)*5+1); imagesc(haar_img1); 
    set(gca,'XTick',[]); set(gca,'YTick',[]);
    ylabel(['$N =\ $', num2str(kernel_size), '\ '], ...
          'fontsize', 22, 'interpreter', 'latex')
    set(get(gca,'ylabel'), 'Rotation', 0, 'HorizontalAlignment',...
        'right', 'VerticalAlignment','middle')
    if row == 1
        title('{Mask 1}', 'fontsize', 22, 'interpreter', 'latex')
    end
    subplot(3, 5, (row-1)*5+2); imagesc(haar_img2); axis off;
    if row == 1
        title('{Mask 2}', 'fontsize', 22, 'interpreter', 'latex')
    end
    subplot(3, 5, (row-1)*5+3); imagesc(haar_img3); axis off;
    if row == 1
        title('{Mask 3}', 'fontsize', 22, 'interpreter', 'latex')
    end
    subplot(3, 5, (row-1)*5+4); imagesc(haar_img4); axis off;
    if row == 1
        title('{Mask 4}', 'fontsize', 22, 'interpreter', 'latex')
    end
    subplot(3, 5, (row-1)*5+5); imagesc(haar_img5); axis off;
    if row == 1
        title('Mask 5', 'fontsize', 22, 'interpreter', 'latex')
    end
    colormap(gray);
    row = row + 1;
    
end

sgtitle('\bf{2D Convolution with Haar-like Masks}', ...
        'fontsize', 22, 'interpreter', 'latex')

    
%% save figure
set(fig1, 'PaperSize',[40, 7], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [40, 7], ...
          'DefaultFigurePosition', [1, 1, 39, 6])
print(fig1, 'part1_haar_masks', '-dpdf', '-fillpage', '-r400')

set(fig2, 'PaperSize',[40, 20], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [40, 20], ...
          'DefaultFigurePosition', [1, 1, 39, 19])
print(fig2, 'part1_haar_output', '-dpdf', '-fillpage', '-r400')
