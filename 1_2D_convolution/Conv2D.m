% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to do 2D convolution between input image g and 2D kernel f.    %
% The convolution output h is obtained after zero padding input g.        %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function [ h ] = Conv2D( f, g )

% dimensions of image g
[X, Y] = size(g);

% dimensions of kernel f
[M, N] = size(f);

% initialise the convolved image 
h = zeros(X+M-1, Y+N-1);

% zero pad the input image 
g = padarray(g, [M-1, N-1], 0, 'post');

% 2D convolution
for x = 1 : X+M-1
    for y = 1 : Y+N-1
        for m = 1 : M
            for n = 1 : N
                if x-m+1 > 0 && y-n+1 > 0
                    h(x,y) = h(x,y) + f(m,n) * g(x-m+1, y-n+1);
                end
            end
        end
    end    
end

% for x = W : X  % W+1
%     for y = H : Y  % H+1
%         for u = 1 : W
%             for v = 1 : H
%                 
%                 h(x,y) = h(x,y) + (f(u,v) * g(x-u+1, y-v+1));
%                 
%             end
%         end
%     end
% end

% h = h(W:end, H:end);

end



