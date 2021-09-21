function out = merge_exposures(exposures, baseIndex, mask_width, blend_width,blend_cap,target_gamma)

numImages = size(exposures, 2);

% blend scalings of all images to match first image exposure
scalings = zeros(numImages);
for i = 1:numImages
    scalings(i) = compute_scaling(exposures{i}, exposures{baseIndex}, mask_width,target_gamma);
end
min_scaling = min(scalings);
max_scaling = max(scalings);

%compute blending weights
weights = cell(1, numImages);
total_weight = zeros(size(exposures{baseIndex}));
for i = 1:numImages
    blend_low=(scalings(i) ~= min_scaling);
    blend_high=(scalings(i) ~= max_scaling);
    weights{i} = double(compute_weight(exposures{i},blend_low,blend_high,blend_width,blend_cap,target_gamma));
    total_weight = imadd(total_weight, weights{i});
end
total_weight = imadd(total_weight, 1e-8);
for i = 1:numImages
    weights{i} = weights{i}./total_weight;
end

%blend scaled images by weight
final_image = double(zeros(size(exposures{baseIndex})));
temp1 = double(zeros(size(exposures{baseIndex})));
temp2 = double(zeros(size(exposures{baseIndex})));
for i = 1:numImages
    temp1 = immultiply(exposures{i},scalings(i));
    temp2 = immultiply(double(temp1), weights{i});
    final_image = imadd(final_image,temp2,'double');
end
        
out = final_image;