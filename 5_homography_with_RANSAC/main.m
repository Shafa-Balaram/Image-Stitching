% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                       Part 5: Homography + RANSAC                       %
%                              Shafa Balaram                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;
rng('default');

% add folders and files to paths
current_path = pwd;
root_dir = current_path(1:find(current_path=='/', 1, 'last')-1);
addpath(genpath(fullfile(root_dir, 'vlfeat-0.9.21')))
addpath(genpath(fullfile(root_dir, 'assg1')))


%%% Step 0: load images 
%%% -------------------

image1 = im2double(imread(fullfile(root_dir, 'assg1', 'im01.jpg')));
image2 = im2double(imread(fullfile(root_dir, 'assg1', 'im02.jpg')));


%%% Step 1: Obtain SIFT keypoints and descriptors using VLFeat
%%% ----------------------------------------------------------

greyscale_image1 = single(rgb2gray(image1)) ;
greyscale_image2 = single(rgb2gray(image2)) ;
[keypoints1, descriptors1] = vl_sift(greyscale_image1);
[keypoints2, descriptors2] = vl_sift(greyscale_image2);
keypoints1_loc = keypoints1(1:2, :);
keypoints2_loc = keypoints2(1:2, :);


%%% Step 2: Keypoint matching 
%%% -------------------------
threshold = 0.8;
[match_idxs] = getMatchedKeypoints(double(descriptors1), ...
                                   double(descriptors2), threshold) ;
matched_pts1 = keypoints1_loc(:, match_idxs(1,:)) ; 
matched_pts2 = keypoints2_loc(:, match_idxs(2,:)) ; 
Nmatches = size(match_idxs, 2);
% image1_width = size(image1,2);


% visualise 
fig1 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 40 20])
imagesc([image1 image2]); axis off ;
image1_width = size(image1,2) ;
line([matched_pts1(1, :); matched_pts2(1, :) + image1_width], ...
     [matched_pts1(2, :); matched_pts2(2, :)], ...
     'Color', 'green', 'linewidth', 1) ;
hold on;
plot(matched_pts1(1, :), matched_pts1(2, :), 'ro', ...
    'MarkerSize', 5, 'linewidth', 1);
hold on;
plot(matched_pts2(1, :) + image1_width, matched_pts2(2, :), 'r*', ...
    'MarkerSize', 5, 'linewidth', 1);
hold on;
title([num2str(Nmatches), '\bf{ keypoint pairs matched using SIFT}'], ...
      'interpreter', 'latex', 'fontsize', 22) ;


%%% Step 3: Find the best homography matrix using RANSAC
%%% ----------------------------------------------------

epsilon = 1;
[Hransac, inliers] = RANSAC(matched_pts1, matched_pts2, epsilon);

% visualise
fig2 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 40 20])
imagesc([image1 image2]); axis off ;
image1_width = size(image1,2) ;
line([matched_pts1(1, inliers); matched_pts2(1, inliers) + image1_width], ...
     [matched_pts1(2, inliers); matched_pts2(2, inliers)], ...
     'Color', 'green', 'linewidth', 1) ;
hold on;
plot(matched_pts1(1, inliers), matched_pts1(2, inliers), 'ro', ...
    'MarkerSize', 5, 'linewidth', 1);
hold on;
plot(matched_pts2(1, inliers) + image1_width, matched_pts2(2, inliers), 'r*', ...
    'MarkerSize', 5, 'linewidth', 1);
hold on;
title([num2str(sum(inliers)), '\bf{ keypoint pairs matched using RANSAC}'], ...
       'interpreter', 'latex', 'fontsize', 22) ;
  

%%% Step 4: Image stitching using the best homography matrix
%%% --------------------------------------------------------

% stitch reference image 1 and transformed image 2
[canvas2] = stitchImagePair(image2, image1, inv(Hransac));

% stitch reference image 1 and transformed image 2
[canvas1] = stitchImagePair(image1, image2, Hransac);

fig3 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 40 15])
subplot(1, 2, 1); imagesc(canvas2); axis off ;
subplot(1, 2, 2); imagesc(canvas1); axis off ;
sgtitle('\bf{Image Stitching using RANSAC + Homography}', ...
        'interpreter', 'latex', 'fontsize', 22) ;


%% save figure
set(fig1, 'PaperSize',[40 20], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [40, 20], ...
          'DefaultFigurePosition', [1, 1, 39, 10])
print(fig1, 'part5_sift', '-dpdf', '-fillpage', '-r400')

set(fig2, 'PaperSize',[40 20], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [40, 20], ...
          'DefaultFigurePosition', [1, 1, 39, 10])
print(fig2, 'part5_ransac', '-dpdf', '-fillpage', '-r400')

set(fig3, 'PaperSize',[40 15], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [40, 15], ...
          'DefaultFigurePosition', [1, 1, 39, 14])
print(fig3, 'part5_mosaic', '-dpdf', '-fillpage', '-r400')
