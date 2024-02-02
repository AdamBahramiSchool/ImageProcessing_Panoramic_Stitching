s1img1=im2double(imread("..\imageSET\S1-im1.png"));
s1img2=im2double(imread("..\imageSET\S1-im2.png"));
s2img1=im2double(imread("..\imageSET\S2-im1.png"));
s2img2=im2double(imread("..\imageSET\S2-im2.png"));
s3img1=im2double(imread("..\imageSET\S3-im1.png"));
s3img2=im2double(imread("..\imageSET\S3-im2.png"));
s4img1=im2double(imread("..\imageSET\S4-im1.png"));
s4img2=im2double(imread("..\imageSET\S4-im2.png"));
s1p=im2double(imread("..\imageSET\Panorama\S1-panorama.png"));
s2p=im2double(imread("..\imageSET\Panorama\S2-panorama.png"));
s3p=im2double(imread("..\imageSET\Panorama\S3-panorama.png"));
s4p=im2double(imread("..\imageSET\Panorama\S4-panorama.png"));

panoramaCreator(s1img1,s1img2,s1p,99,500,FASTRfunction(s1img1,FASTfunction(s1img1,0.0011)),FASTRfunction(s1img2,FASTfunction(s1img2,0.0011)));
panoramaCreator(s2img1,s2img2,s2p,99,500,FASTRfunction(s2img1,FASTfunction(s2img1,0.0011)),FASTRfunction(s2img2,FASTfunction(s2img2,0.0011)));
panoramaCreator(s3img1,s3img2,s3p,99,500,FASTRfunction(s3img1,FASTfunction(s3img1,0.0011)),FASTRfunction(s3img2,FASTfunction(s3img2,0.0011)));
panoramaCreator(s4img1,s4img2,s4p,99,500,FASTRfunction(s4img1,FASTfunction(s4img1,0.0011)),FASTRfunction(s4img2,FASTfunction(s4img2,0.0011)));
