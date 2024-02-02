# **Image Stitching and FAST Feature Detection Assignment**

## **Overview**
In this assignment, I implemented the FAST interest point detector and used it to generate panoramas from sets of images. The assignment involved taking pairs of photographs, implementing FAST feature detection, robustifying FAST with the Harris cornerness metric, describing and matching points, using RANSAC for homography estimation, and finally, stitching images together to create panoramas.

## **Requirements**
This assignment could be implemented in any programming language, but I chose to use MATLAB due to its relevance to the course material.

## **Instructions**
### **Image Acquisition**
- I took four sets of two photographs each, to be stitched together into panoramas.
- I resized the images so that the longer dimension (height or width) was 750 pixels.
- I submitted the image pairs named as follows: S1-im1.png, S1-im2.png, ..., S4-im1.png, S4-im2.png.

### **FAST Feature Detector (3 pts.)**
- I implemented the FAST interest point detector, including the high-speed test, as a function named my_fast_detector.
- I visualized the detected points in the first images of each image set as S1-fast.png, S2-fast.png, etc.

### **Robust FAST with Harris Cornerness Metric (1 pt.)**
- I computed the Harris cornerness measure for each detected FAST feature.
- I discarded weak FAST points based on a fixed threshold for the Harris metric.
- I visualized the remaining points as S1-fastR.png, S2-fastR.png, etc.
- I noted the average computation time of FAST and FASTR features and commented on the difference.

### **Point Description and Matching (2 pts.)**
- I used an existing implementation of one of ORB, SURF, or FREAK feature description methods to generate descriptors for FAST and FASTR points.
- I matched features between the first two images in each photo set.
- I visualized the matched points using FAST and FASTR points as S1-fastMatch.png, S1-fastRMatch.png, etc.
- I commented on any performance differences observed.

### **RANSAC and Panoramas (4 pts.)**
- I used RANSAC to compute the homography between each pair of images.
- I experimented with RANSAC parameters to find a setup with a minimum number of trials while still producing satisfactory results for all image sets.
- I saved the stitched images for all image sets using only FASTR points as S1-panorama.png, S2-panorama.png, etc.
- I commented on the difference between optimal RANSAC parameters for FAST and FASTR.

### **Bonus: Stitch 4 Images Instead of 2 (2 pts.)**
- I included 4 images in at least two of my image sets and presented panoramas that resulted in stitching all 4 images.
