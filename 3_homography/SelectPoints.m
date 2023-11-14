% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to create a GUI for user to select N points on each input      %
% image.                                                                  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


function [X1, X2] = SelectPoints(image1, image2, N)

    % image dimensions
    [height, width, ~] = size(image1);
    
    % initialise arrays to save selected points 
    X1 = zeros(2, N);
    X2 = zeros(2, N);
    
    % visualise the image and select points
    fig1 = figure('Color', [1, 1, 1]); 
    set(gcf,'units','centimeters','Position',[1 1 45 20])
    ax1 = subplot(1, 2, 1);
    imagesc(image1); axis off;
    title('\bf{None selected}', 'fontsize', 16, 'interpreter', 'latex')
    ax2 = subplot(1, 2, 2);
    imagesc(image2); axis off;
    title('\bf{None selected}', 'fontsize', 16, 'interpreter', 'latex')
    sgtitle({'\bf{\ \ \ \ \ Left click to select 4 homography points}', ' '}, ...
        'interpreter', 'latex', 'fontsize', 20)
    
    % left click to select in image 1
    axes(ax1)
    for n = 1 : N
        [x, y, ~] = ginput(1);
   
        while x < 1 || x > width || y < 1 || y > height
            [x, y, ~] = ginput(1);
        end
   
        X1(1, n) = x;
        X1(2, n) = y;
   
        hold on
        plot(x, y, 'Color', [1, 0, 0], 'Marker', 'o', 'MarkerSize', 8, ...
             'MarkerFaceColor',[1, 0, 0])   
        title([num2str(n), '\bf{ selected}'], ...
              'interpreter', 'latex', 'fontsize', 16)
    end
    
    % left click to select in image 2
    axes(ax2)
    for n = 1 : N
        [x, y, ~] = ginput(1);
   
        while x < 1 || x > width || y < 1 || y > height
            [x, y, ~] = ginput(1);
        end
   
        X2(1, n) = x;
        X2(2, n) = y;
   
        hold on
        plot(x, y, 'Color', [0, 1, 0], 'Marker', 'o', 'MarkerSize', 8, ...
             'MarkerFaceColor',[0, 1, 0])   
        title([num2str(n), '\bf{ selected}'], ...
              'fontsize', 16, 'interpreter', 'latex')
    end

    pause(1); close;
    
end

