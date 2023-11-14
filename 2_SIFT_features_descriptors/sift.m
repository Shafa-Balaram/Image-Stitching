% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                  Part 2: SIFT Features and Descriptors                  %
%            The script uses vl_sift from the vl_feat toolbox             %
%                              Shafa Balaram                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% https://stackoverflow.com/questions/3277541/construct-adjacency-matrix-in-matlab

close all; clear all; clc; 

% seed the random number generator
rng('default')

% add folders and files to paths
current_path = pwd;
root_dir = current_path(1:find(current_path=='/', 1, 'last')-1);
addpath(genpath(fullfile(root_dir, 'vlfeat-0.9.21')))
addpath(genpath(fullfile(root_dir, 'assg1')))


%%% Step 0: Load the example greyscale image
%%% ----------------------------------------

% load image
image_path = fullfile(root_dir, 'assg1', 'im01.jpg');
image = imread(image_path);

% convert image to greyscale and single precision 
greyscale_image = single(rgb2gray(image));


%%% Step 1: Obtain the SIFT keypoints and descriptors
%%% -------------------------------------------------

[keypoints, descriptors] = vl_sift(greyscale_image) ;


%%% Step 2: Visualise
%%% -----------------

% visualise the image 
fig1 = figure('Color', [1, 1, 1]); 
set(gcf,'units','centimeters','Position',[1 1 25 20])
imagesc(image); axis off;
hold on

% visualise the keypoints
perm = randperm(size(keypoints, 2)) ;
sel = perm(1:100) ;
h1 = vl_plotframe(keypoints(:, sel)) ;
h2 = vl_plotframe(keypoints(:, sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;


% visualise the descriptors 
h3 = vl_plotsiftdescriptor(descriptors(:, sel), keypoints(:, sel)) ;
set(h3, 'color', 'b') ;

title('\bf{SIFT keypoints and descriptors in im01.jpg}', ...
      'fontsize', 22, 'interpreter', 'latex')
    
  
%% save figure
set(fig1, 'PaperSize',[25 20], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [25, 20], ...
          'DefaultFigurePosition', [1, 1, 24, 19])
print(fig1, 'part2_sift', '-dpdf', '-fillpage', '-r400')

