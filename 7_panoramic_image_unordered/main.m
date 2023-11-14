% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                    Part 7: Advanced Panoramic Image                     %
%    The script scrambles the images in assg1 folder and stitches them.   %
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
shuffled_idx = randperm(N, N);
for n = 1 : N 
  images{n} = im2double(imread(image_files(shuffled_idx(n)).name)); 
end


%%% Step 1: Order images for stitching 
%%% ----------------------------------

% set parameters
ratio = 0.8;
epsilon = 1;

% order images 
order = getStitchOrder(images, ratio, epsilon);
fprintf(['Image order: ', num2str(order), '\n'])
ordered_images = images(1, order);


%%% Step 2: Panoramic image 
%%% -----------------------

% parameters
ratio = 0.8; epsilon = 1;

% obtain the resultant panoramas
panorama = stitchMultiImages(ordered_images, 2, ratio, epsilon);
fprintf('Stitching 5 images \n')


%%% Step 3: Visualise
%%% -----------------

fig1 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 40 25])

for n = 1 : N
    subplot(2, 5, n); 
    imagesc(images{n}); axis off;
    title(image_files(shuffled_idx(n)).name, 'fontsize', 22, ...
          'interpreter', 'latex')
end

subplot(2, 5, [6:10]); imagesc(panorama); axis off;
title('Panorama of the 5 Images', 'fontsize', 22, ...
          'interpreter', 'latex')
      
sgtitle('\bf{Stitching Unordered Images using RANSAC + Homography}', ...
        'fontsize', 22, 'interpreter', 'latex')    

    
%% save figure
set(fig1, 'PaperSize',[40 25], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [40, 25], ...
          'DefaultFigurePosition', [1, 1, 39, 24])
print(fig1, 'part7_panorama', '-dpdf', '-fillpage', '-r400')

toc
