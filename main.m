% input:
%  folder: the (relative) path containing the input images set.
%  All input images must be RAW images. The exposure of the first image is
%  taken as reference for the brightness of the resulting HDR image.



function main(folder)
% Initialization
addpath(genpath('Functions'));

%Parameters
mask_width = 0.8;
target_gamma = 2.2;
blend_width = 0.2;
blend_cap = 0.1;
sceneName = 'Test';
save_memory = 'True';

%Load folder containing RAW images
if( ~exist('folder') )
folder = 'Scenes/Test'; % no tailing slash!
end
sceneFolder = sprintf('%s', folder);
if (~exist(sceneFolder, 'dir'))
    error('Scene folder does not exist');
end
listOfFiles = dir(sprintf('%s\\*.CR2', sceneFolder));
numImages = size(listOfFiles, 1);

%Read Raw Images
inputLDRs = cell(1, numImages);
for i = 1 : numImages
    Path = sprintf('%s\\%s', folder, listOfFiles(i).name);
    inputLDRs{i} = imread(readraw, Path, '-a -T -6 -q 3');
    inputLDRs{i} = im2double(inputLDRs{i});
end

%Merge RAW images into a single HDR image
hdrmerge(inputLDRs, 'resulttest.hdr', save_memory,mask_width, blend_width, blend_cap,target_gamma);

