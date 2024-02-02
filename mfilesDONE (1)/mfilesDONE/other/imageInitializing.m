%Do this for all image sets, grayscaling and resizing image
s1img1=rgb2gray(im2double(imread("imageSet\S1-im1.png")));
[height,width,channels]=size(s1img1);
biggerDimension=max(height,width);
aspectRatio=750/biggerDimension;
imgresizeds11=imresize(s1img1,[height.*aspectRatio,width.*aspectRatio]);
imwrite(imgresizeds11,"imageSet\S1-im1.png");

s1img2=rgb2gray(im2double(imread("imageSet\S1-im2.png")));
[height,width,channels]=size(s1img2);
biggerDimension=max(height,width);
aspectRatio=750/biggerDimension;
imgresizeds12=imresize(s1img2,[height.*aspectRatio,width.*aspectRatio]);
imwrite(imgresizeds12,"imageSet\S1-im2.png");

s2img1=rgb2gray(im2double(imread("imageSet\S2-im1.png")));
[height,width,channels]=size(s2img1);
biggerDimension=max(height,width);
aspectRatio=750/biggerDimension;
imgresizeds21=imresize(s2img1,[height.*aspectRatio,width.*aspectRatio]);
imwrite(imgresizeds21,"imageSet\S2-im1.png");

s2img2=rgb2gray(im2double(imread("imageSet\S2-im2.png")));
[height,width,channels]=size(s2img2);
biggerDimension=max(height,width);
aspectRatio=750/biggerDimension;
imgresizeds22=imresize(s2img2,[height.*aspectRatio,width.*aspectRatio]);
imwrite(imgresizeds22,"imageSet\S2-im2.png");

s3img1=rgb2gray(im2double(imread("imageSet\S3-im1.png")));
[height,width,channels]=size(s3img1);
biggerDimension=max(height,width);
aspectRatio=750/biggerDimension;
imgresizeds31=imresize(s3img1,[height.*aspectRatio,width.*aspectRatio]);
imwrite(imgresizeds31,"imageSet\S3-im1.png");

s3img2=rgb2gray(im2double(imread("imageSet\S3-im2.png")));
[height,width,channels]=size(s3img2);
biggerDimension=max(height,width);
aspectRatio=750/biggerDimension;
imgresizeds32=imresize(s3img2,[height.*aspectRatio,width.*aspectRatio]);
imwrite(imgresizeds32,"imageSet\S3-im2.png");

s4img1=rgb2gray(im2double(imread("imageSet\S4-im1.png")));
[height,width,channels]=size(s4img1);
biggerDimension=max(height,width);
aspectRatio=750/biggerDimension;
imgresizeds41=imresize(s4img1,[height.*aspectRatio,width.*aspectRatio]);
imwrite(imgresizeds41,"imageSet\S4-im1.png");

s4img2=rgb2gray(im2double(imread("imageSet\S4-im2.png")));
[height,width,channels]=size(s4img2);
biggerDimension=max(height,width);
aspectRatio=750/biggerDimension;
imgresizeds42=imresize(s4img2,[height.*aspectRatio,width.*aspectRatio]);
imwrite(imgresizeds42,"imageSet\S4-im2.png");
