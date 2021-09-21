% input:
%  folder: the (relative) path containing the input images set. All input images must be RAW images. 
%  baseIndex: The index of the image whose exposure is taken as reference for the brightness of the resulting HDR image.
%  mask_width(float): Size of the mask in gamma-corrected color space.
%  blend_width(float): Width of the blended regions at both ends of the brightness range.
%  blend_cap(float): Cap of dark and bright regions.
%  target_gamma(float): Target gamma used for the masking computations.

function main(folder, baseIndex, mask_width, blend_width, blend_cap,target_gamma)
% Initialization
addpath(genpath('Functions'));

%Set default load folder containing RAW images, if user does not set it.
if( ~exist('folder') )
    folder = 'CR2/Scene1'; % no tailing slash!
end

%Set Parameters to default values if the user does not set them.
if( ~exist('baseIndex'))
    baseIndex = 7;
end
if( ~exist('mask_width'))
    mask_width = 0.8;
end
if( ~exist('blend_width'))
    blend_width = 0.2;
end
if( ~exist('blend_cap'))
    blend_cap = 0.1;
end
if( ~exist('target_gamma'))
    target_gamma = 2.2;
end

%Check for erroneous input values
if (mask_width <= 0 | mask_width > 1)
    error('Mask width must be positive and at most 1.0');
end
if ~((0 <= blend_width) && (blend_width <= 0.5))
    error('Invalid value for `blend_width`. Must be in range [0, 0.5]');
end
if ~( (0 <= blend_cap) &&  (blend_cap <= 0.5))
    error('Invalid value for `blend_cap`. Must be in range [0, 0.5]');
end
if ((blend_width + blend_cap) > 0.5)
    error('Invalid value for `blend_width` + `blend_cap`, Sum must be less than 0.5');
end
if (target_gamma <= 0)
    error('Invalid value for `target_gamma`. Must be positive');
end

sceneFolder = sprintf('%s', folder);
%Check for empty/invalid scene folder
if (~exist(sceneFolder, 'dir'))
    error('Scene folder does not exist');
end
listOfFiles = dir(sprintf('%s\\*.CR2', sceneFolder));
if(isempty(listOfFiles))
    error('Scene folder is empty');
end

%Read Raw Images
numImages = size(listOfFiles, 1);
if (numImages < baseIndex)
    error('Index of choosen base image is invalid');
end
inputLDRs = cell(1, numImages);
for i = 1 : numImages
    Path = sprintf('%s\\%s', folder, listOfFiles(i).name);
    inputLDRs{i} = imread(readraw, Path, '-a -T -6 -q 3');
    inputLDRs{i} = im2double(inputLDRs{i});
end

%Merge RAW images into a single HDR image
hdrmerge(inputLDRs, folder ,baseIndex, mask_width, blend_width, blend_cap,target_gamma);

