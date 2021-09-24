function out = hdrmerge(images, outputPath, baseIndex, mask_width, blend_width, blend_cap, target_gamma)

merged = merge_exposures( images, baseIndex, mask_width, blend_width, blend_cap, target_gamma);
hdrwrite(merged,append(outputPath,'/', 'fusedimagetest.hdr'))

%rgb = tonemap(merged,'AdjustLightness' ,[0.45 0.85]);
rgb = tonemap(merged); 
%figure, imshow(rgb);

imwrite(rgb,append(outputPath,'/', 'fusedimagetest.tif'),'tif');
imwrite(rgb,append(outputPath,'/', 'fusedimagetest.bmp'),'bmp');
imwrite(rgb,append(outputPath,'/', 'fusedimagetest.jpg'),'jpg');
