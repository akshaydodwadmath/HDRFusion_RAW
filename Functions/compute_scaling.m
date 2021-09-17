function out = compute_scaling(image, base_image, mask_width , target_gamma )

%Compute mask where all image data is in reasonable sensor range
mask = double(ones(size(image),'like',image));
mask_min = 0.5 - 0.5 * mask_width;
mask_max = 0.5 + 0.5 * mask_width;
image_gammac = double(image).^(1.0 / target_gamma);
base_image_gammac = double(base_image).^(1.0 / target_gamma);
mask = ((base_image_gammac >= mask_min) & (base_image_gammac <= mask_max) & (image_gammac >= mask_min)& (image_gammac <= mask_max));

%Compute scaling of `image` image to match exposure of `base_image`
temp_image = double(base_image(mask) ./ image(mask));
out = mean(temp_image, 'all');
