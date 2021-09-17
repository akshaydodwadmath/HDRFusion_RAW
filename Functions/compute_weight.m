function out = compute_weight(image, blend_low, blend_high,blend_width,blend_cap,target_gamma)

% gamma-corrected image
image_gammac = double(image).^(1.0 / target_gamma);    
mask = double(ones(size(image),'like',image));

% blend out dark pixels
if (blend_low)
    masktemp = imsubtract(image_gammac,blend_cap);
    masktemp = masktemp ./ blend_width;
    masktemp(masktemp>1)=1;
    masktemp(masktemp<0)=0;
    mask = min(masktemp,mask);
end

%blend out bright pixels
if (blend_high)
    image_gammac2 = image_gammac .* -1;
    masktemp = imadd(image_gammac2, 1);
    masktemp = imsubtract(masktemp, blend_cap);
    masktemp = masktemp ./ blend_width;
    masktemp(masktemp>1)=1;
    masktemp(masktemp<0)=0;
    mask = min(masktemp,mask);
end

out = mask;