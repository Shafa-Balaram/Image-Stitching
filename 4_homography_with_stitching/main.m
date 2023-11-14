% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                  Part 4: Manual Homography + Stitching                  %
%           Script takes around 30 seconds to run to completion           %
%                              Shafa Balaram                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;
rng('default');

% add folders and files to paths
current_path = pwd;
root_dir = current_path(1:find(current_path=='/', 1, 'last')-1);
addpath(genpath(fullfile(root_dir, 'assg1')))


%%% Step 0: load images 
%%% -------------------

image1 = im2double(imread(fullfile(root_dir, 'assg1', 'im01.jpg')));
image2 = im2double(imread(fullfile(root_dir, 'assg1', 'im02.jpg')));


%%% Step 1: select 4 homography points from each image
%%% --------------------------------------------------

% number of homography points to select (2x2 windows next to the corner)
N = 4;

% select homography points 
[X1, X2] = SelectPoints(image1, image2, N);


%%% Step 2: compute homography matrix from h2.jpg to h1.jpg
%%% -------------------------------------------------------

H = getHomographyMatrix(X1, X2);
fprintf(['Homography matrix \n'])
H
fprintf(['Norm = ', num2str(norm(H)), '\n \n'])


%%% Step 3: Image stitching using the best homography matrix
%%% --------------------------------------------------------

% stitch reference image 1 and transformed image 2
mosaic = stitchImagePair(image1, image2, H);


%%% Step 4: Visualise the results
%%% -----------------------------

fig1 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 48 11])

subplot(1, 3, 1); imagesc(image1); axis off; hold on;
title('\bf{im01.jpg}', 'fontsize', 22, 'interpreter', 'latex')
for n = 1 : N
    plot(X1(1, n), X1(2, n), 'Color', [1, 0, 0], 'Marker', 'o', ...
         'MarkerSize', 6, 'MarkerFaceColor', [1, 0, 0]); 
     hold on;
end

subplot(1, 3, 2); imagesc(image2); axis off; hold on;
title('\bf{im02.jpg}', 'fontsize', 22, 'interpreter', 'latex')
for n = 1 : N
    plot(X2(1, n), X2(2, n), 'Color', [0, 1, 0], 'Marker', 'o', ...
         'MarkerSize', 6, 'MarkerFaceColor', [0, 1, 0]); 
     hold on;
end

subplot(1, 3, 3); imagesc(mosaic); axis off;
title('\bf{Manual Stitching}', 'fontsize', 22, 'interpreter', 'latex')


%% save figure
set(fig1, 'PaperSize',[48 11], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [48, 11], ...
          'DefaultFigurePosition', [1, 1, 47, 10])
print(fig1, 'part4_stitch', '-dpdf', '-fillpage', '-r400')
