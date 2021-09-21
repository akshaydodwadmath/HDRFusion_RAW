function out = hdrmerge(images, outputPath, baseIndex, mask_width, blend_width, blend_cap, target_gamma)

merged = merge_exposures( images, baseIndex, mask_width, blend_width, blend_cap, target_gamma);
hdrwrite(merged,append(outputPath,'/', 'fusedimage.hdr'))

rgb = tonemap(merged);
imwrite(rgb,append(outputPath,'/', 'fusedimage.tif'),'tif');