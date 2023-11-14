% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                      Part 6: Basic Panoramic Image                      %
%                   Script takes around 1 minute to run                   %
%                              Shafa Balaram                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;
rng('default');

% add folders and files to paths
current_path = pwd;
root_dir = current_path(1:find(current_path=='/', 1, 'last')-1);
image_dir = fullfile(root_dir, 'assg1');
addpath(genpath(fullfile(root_dir, 'vlfeat-0.9.21')))
addpath(genpath(image_dir))

% start timer 
tic

%%% Step 0: load images in order from directory
%%% -------------------------------------------

image_files = dir(fullfile(image_dir, '*.jpg')); 

% select the number of images to use
N = 5;

images = cell(1, N);
for n = 1 : N 
  images{n} = im2double(imread(image_files(n).name)); 
end


%%% Step 1: Basic panoramic image with any image as reference 
%%% ---------------------------------------------------------

% parameters
ratio = 0.8; epsilon = 1;

% obtain the resultant panoramas
[canvas1] = stitchMultiImages(images(1, 1:3), 2, ratio, epsilon);
[canvas1_wide] = stitchMultiImages(images(1, 1:3), 1, ratio, epsilon);
fprintf('Stitching 3 images \n')

[canvas2] = stitchMultiImages(images(1, 1:4), 2, ratio, epsilon);
fprintf('Stitching 4 images \n')

[canvas3] = stitchMultiImages(images(1, 1:5), 2, ratio, epsilon);
fprintf('Stitching 5 images \n')


%%% Step 2: Visualise
%%% -----------------

fig1 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 40 35])

subplot(2, 2, 1); imagesc(canvas1); axis off;
title('First 3 Images', 'interpreter', 'latex', 'fontsize', 22)

subplot(2, 2, 2); imagesc(canvas2); axis off;
title('First 4 Images', 'interpreter', 'latex', 'fontsize', 22)

subplot(2, 2, [3 4]); imagesc(canvas3); axis off;
title('All 5 Images', 'interpreter', 'latex', 'fontsize', 22)

sgtitle('\bf{Basic Panoramic Image using SIFT + RANSAC}', ...
        'interpreter', 'latex', 'fontsize', 22);

fig2 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 40 15])
imagesc(canvas1_wide); axis off;
title('\bf{Stretched Panorama of First 3 Images}', ...
      'interpreter', 'latex', 'fontsize', 22)

  
%% save figure
set(fig1, 'PaperSize',[40 35], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [40, 35], ...
          'DefaultFigurePosition', [1, 1, 39, 34])
print(fig1, 'part6_panorama', '-dpdf', '-fillpage', '-r400')

set(fig2, 'PaperSize',[40 15], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [40, 15], ...
          'DefaultFigurePosition', [1, 1, 39, 14])
print(fig2, 'part6_panorama_wide', '-dpdf', '-fillpage', '-r400')

toc
