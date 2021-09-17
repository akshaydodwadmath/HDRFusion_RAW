function out = hdrmerge(images, output, savememory, mask_width, blend_width, blend_cap,target_gamma)

weight_first = 'False';

% Load one image after another to save memory
if(savememory)
    baseImage = images(1); 
    other_images = images(2:end);
    totImage = size(other_images);
    for i = 1:totImage
        image = other_images(i);
        merged = merge_exposures( images, mask_width, blend_width, blend_cap, target_gamma, weight_first);
        %imwrite(merged, output);
        hdrwrite(merged,output)
    end
end