% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                            Part 3: Homography                           %
%                              Shafa Balaram                              %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;


%%% Step 0: load the images and convert to double precision
%%% -------------------------------------------------------

image1 = im2double(imread('h1.jpg'));
image2 = im2double(imread('h2.jpg'));


%%% Step 1: select 4 homography points from each image
%%% --------------------------------------------------

% number of homography points to select 
N = 4;

% select homography points 
[X1, X2] = SelectPoints(image1, image2, N);


%%% Step 2: compute homography matrix from h1.jpg to h2.jpg
%%% --------------------------------------------------------

H1 = getHomographyMatrix(X1, X2);
fprintf(['Homography matrix \n'])
H1
fprintf(['Norm = ', num2str(norm(H1)), '\n \n'])


%%% Step 3: Transform h1.jpg to h2.jpg using the homography matrix
%%% --------------------------------------------------------------

transformed_image1 = applyTransform(image1, H1);


%%% Step 4: compute homography matrix from h2.jpg to h1.jpg
%%% -------------------------------------------------------

H2 = getHomographyMatrix(X2, X1);
fprintf(['Homography matrix \n'])
H2
fprintf(['Norm = ', num2str(norm(H2)), '\n \n'])


%%% Step 5: Transform h2.jpg to h1.jpg using the homography matrix
%%% --------------------------------------------------------------

transformed_image2 = applyTransform(image2, H2);


%%% Step 6: Visualise the results
%%% -----------------------------

% visualise
fig1 = figure('Color', [1,1,1]); 
set(gcf,'units','centimeters','Position',[1 1 48 11])

subplot(1, 4, 1); imagesc(image1); axis off; hold on;
title('\bf{h1}', 'fontsize', 20, 'interpreter', 'latex')
for n = 1 : N
    plot(X1(1, n), X1(2, n), 'Color', [1, 0, 0], 'Marker', 'o', ...
         'MarkerSize', 8, 'MarkerFaceColor', [1, 0, 0]); 
     hold on;
end

subplot(1, 4, 2); imagesc(image2); axis off; hold on;
title('\bf{h2}', 'fontsize', 20, 'interpreter', 'latex')
for n = 1 : N
    plot(X2(1, n), X2(2, n), 'Color', [0, 1, 0], 'Marker', 'o', ...
         'MarkerSize', 8, 'MarkerFaceColor', [0, 1, 0]); 
     hold on;
end

subplot(1, 4, 3); imagesc(transformed_image1); axis off;
title('\bf{transformed h1}', 'fontsize', 20, 'interpreter', 'latex')
subplot(1, 4, 4); imagesc(transformed_image2); axis off;
title('\bf{transformed h2}', 'fontsize', 20, 'interpreter', 'latex')


%% save figure
set(fig1, 'PaperSize',[48 11], ...
          'DefaultFigurePaperUnits', 'centimeters', ...
          'DefaultFigureUnits', 'centimeters', ...
          'DefaultFigurePaperSize', [48, 11], ...
          'DefaultFigurePosition', [1, 1, 47, 10])
print(fig1, 'part3_homography', '-dpdf', '-fillpage', '-r400')

