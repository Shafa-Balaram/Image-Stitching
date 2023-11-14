% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%                     Image Stitching (Visual Computing)                  %
%                  Part 2: SIFT Features and Descriptors                  %
%                              Shafa Balaram                              %
%                                                                         %
% - SIFT code folder downloaded from https://www.vlfeat.org               %
% - To install Matlab Mex files on MacOS, follow instructions at:         %
% http://www.fieldtriptoolbox.org/faq/mexmaci64_cannot_be_opened_because_ %
% the_developer_cannot_be_verified/                                       %
%                                                                         %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

close all; clear all; clc;
root_dir = 'Image-Stitching';
addpath(genpath(fullfile(root_dir, 'vlfeat-0.9.21')))

% install vl_feat
run('vlfeat-0.9.21/toolbox/vl_setup')

%% run the following in Terminal 
% sudo xattr -r -d com.apple.quarantine Desktop/EE5731/assignment\ 1/vlfeat-0.9.21
% sudo find Image-Stitching/vlfeat-0.9.21 -name \*.mexmaci64 -exec spctl --add {} \;

%% check if vl_feat is successfully installed
vl_version verbose

%% SIFT demo
vl_demo_sift_basic

