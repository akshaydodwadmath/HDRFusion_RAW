# HDRFusion_RAW

Matlab based merging of multiple RAW images to a single HDR image (Python package Rawhdr used as reference (https://pypi.org/project/rawhdr/) . 
Use the command line to run the main program with the input as the folder containing the LDR RAW images, and the index of the image used for setting the exposure. 

```
main('folder_name', 'baseImage_index')
```

A single HDR image in .hdr format is generated as output.

Note: Processing of Raw images done by referring https://www.rcsumner.net/raw_guide/. If you are using DCRaw option to read RAW images within MATLAB, you might need to install as documented here https://gitlab.com/astrophotography/matlab-readraw.
