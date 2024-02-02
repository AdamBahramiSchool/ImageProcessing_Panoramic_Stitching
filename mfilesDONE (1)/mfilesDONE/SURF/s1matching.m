% For s1img1
s1img1 = im2double(imread("..\imageSet\S1-im1.png"));
gausKern1 = fspecial("gaussian", 20, 2);
s1img1Filtered = imfilter(s1img1, gausKern1);
shifted_right1 = matrixshift(s1img1Filtered, [0, 1]);
shifted_left1 = matrixshift(s1img1Filtered, [0, -1]);
shifted_up1 = matrixshift(s1img1Filtered, [-1, 0]);
shifted_down1 = matrixshift(s1img1Filtered, [1, 0]);

shifted_up_right1 = matrixshift(s1img1Filtered, [-1, 1]);
shifted_up_left1 = matrixshift(s1img1Filtered, [-1, -1]);
shifted_down_right1 = matrixshift(s1img1Filtered, [1, 1]);
shifted_down_left1 = matrixshift(s1img1Filtered, [1, -1]);
fastThreshold1 = 0.00000011;

% Check if a set of N contiguous pixels in the circle are all brighter than Ip + t
is_brighter_right1 = s1img1Filtered + fastThreshold1 < shifted_right1;
is_brighter_left1 = s1img1Filtered + fastThreshold1 < shifted_left1;
is_brighter_up1 = s1img1Filtered + fastThreshold1 < shifted_up1;
is_brighter_down1 = s1img1Filtered + fastThreshold1 < shifted_down1;
is_brighter_up_right1 = s1img1Filtered + fastThreshold1 < shifted_up_right1;
is_brighter_up_left1 = s1img1Filtered + fastThreshold1 < shifted_up_left1;
is_brighter_down_right1 = s1img1Filtered + fastThreshold1 < shifted_down_right1;
is_brighter_down_left1 = s1img1Filtered + fastThreshold1 < shifted_down_left1;
highspeedCornerTest1 = is_brighter_right1 & is_brighter_left1 & is_brighter_up1 & is_brighter_down1 & is_brighter_up_right1 & is_brighter_up_left1 & is_brighter_down_right1 & is_brighter_down_left1;
[row1, col1] = find(highspeedCornerTest1);
candidatecorners1 = [row1, col1];
sobKern1 = [-1 0 1; -2 0 2; -1 0 1];
gausKern2 = fspecial("gaussian", 10, 2);
dogKern1 = conv2(gausKern2, sobKern1);
ix1 = imfilter(s1img1Filtered, dogKern1);
iy1 = imfilter(s1img1Filtered, dogKern1');
ix2gaussian1 = imfilter(ix1 .* ix1, gausKern2);
iy2gaussian1 = imfilter(iy1 .* iy1, gausKern2);
ixiygaussian1 = imfilter(ix1 .* iy1, gausKern2);
harrisCornerMeasure1 = ix2gaussian1 .* iy2gaussian1 - ixiygaussian1 - 0.05 .* (ix2gaussian1 + iy2gaussian1) .^ 2;
localMax1 = imdilate(harrisCornerMeasure1, ones(3));
outputCornersHarris1 = ((harrisCornerMeasure1 == localMax1) .* (harrisCornerMeasure1 > 0.06));

[row2, col2] = find(outputCornersHarris1);
remainingFAST1 = [];
radius = 60;
for i = 1:numel(row2)
    hcX = col2(i);
    hcY = row2(i);
    distance = sqrt((candidatecorners1(:, 2) - hcX) .^ 2 + (candidatecorners1(:, 1) - hcY) .^ 2);
    inRangeFAST = candidatecorners1(distance <= radius, :);
    remainingFAST1 = [remainingFAST1; inRangeFAST];
end

% For s1img2
s1img2 = im2double(imread("..\imageSet\S1-im2.png"));
gausKern3 = fspecial("gaussian", 20, 2);
s1img2Filtered = imfilter(s1img2, gausKern3);
shifted_right2 = matrixshift(s1img2Filtered, [0, 1]);
shifted_left2 = matrixshift(s1img2Filtered, [0, -1]);
shifted_up2 = matrixshift(s1img2Filtered, [-1, 0]);
shifted_down2 = matrixshift(s1img2Filtered, [1, 0]);
shifted_up_right2 = matrixshift(s1img2Filtered, [-1, 1]);
shifted_up_left2 = matrixshift(s1img2Filtered, [-1, -1]);
shifted_down_right2 = matrixshift(s1img2Filtered, [1, 1]);
shifted_down_left2 = matrixshift(s1img2Filtered, [1, -1]);
fastThreshold2 = 0.00000011;
is_brighter_right2 = s1img2Filtered + fastThreshold2 < shifted_right2;
is_brighter_left2 = s1img2Filtered + fastThreshold2 < shifted_left2;
is_brighter_up2 = s1img2Filtered + fastThreshold2 < shifted_up2;
is_brighter_down2 = s1img2Filtered + fastThreshold2 < shifted_down2;
is_brighter_up_right2 = s1img2Filtered + fastThreshold2 < shifted_up_right2;
is_brighter_up_left2 = s1img2Filtered + fastThreshold2 < shifted_up_left2;
is_brighter_down_right2 = s1img2Filtered + fastThreshold2 < shifted_down_right2;
is_brighter_down_left2 = s1img2Filtered + fastThreshold2 < shifted_down_left2;

% Boolean check, if boolean conditions have contiguous pixels results in true, it's a corner
highspeedCornerTest2 = is_brighter_right2 & is_brighter_left2 & is_brighter_up2 & is_brighter_down2 & is_brighter_up_right2 & is_brighter_up_left2 & is_brighter_down_right2 & is_brighter_down_left2;
[row3, col3] = find(highspeedCornerTest2);
% List the candidate pixels as corners
candidatecorners2 = [row3, col3];
sobKern2 = [-1 0 1; -2 0 2; -1 0 1];
gausKern4 = fspecial("gaussian", 10, 2);
dogKern3 = conv2(gausKern4, sobKern2);
ix2 = imfilter(s1img2Filtered, dogKern3);
iy2 = imfilter(s1img2Filtered, dogKern3');
ix2gaussian2 = imfilter(ix2 .* ix2, gausKern4);
iy2gaussian2 = imfilter(iy2 .* iy2, gausKern4);
ixiygaussian2 = imfilter(ix2 .* iy2, gausKern4);
harrisCornerMeasure2 = ix2gaussian2 .* iy2gaussian2 - ixiygaussian2 - 0.05 .* (ix2gaussian2 + iy2gaussian2) .^ 2;
localMax2 = imdilate(harrisCornerMeasure2, ones(3));
outputCornersHarris2 = ((harrisCornerMeasure2 == localMax2) .* (harrisCornerMeasure2 > 0.06));

[row4, col4] = find(outputCornersHarris2);
remainingFAST2 = [];
radius = 60;
for i = 1:numel(row4)
    hcX = col4(i);
    hcY = row4(i);
    distance = sqrt((candidatecorners2(:, 2) - hcX) .^ 2 + (candidatecorners2(:, 1) - hcY) .^ 2);
    inRangeFAST2 = candidatecorners2(distance <= radius, :);
    remainingFAST2 = [remainingFAST2; inRangeFAST2];
end
imshow(s1img2); hold on;
scatter(remainingFAST2(:,2), remainingFAST2(:,1), 50, 'b', 'filled');
hold off;
imshow(s1img1); hold on;
scatter(remainingFAST1(:,2), remainingFAST1(:,1), 50, 'b', 'filled');
hold off;

[surfFeaturesFAST1, validPointsFAST1] = extractFeatures(s1img1, candidatecorners1, 'Method', 'SURF');
[surfFeaturesFASTR1, validPointsFASTR1] = extractFeatures(s1img1, remainingFAST1, 'Method', 'SURF');
[surfFeaturesFAST2, validPointsFAST2] = extractFeatures(s1img2, candidatecorners2, 'Method', 'SURF');
[surfFeaturesFASTR2, validPointsFASTR2] = extractFeatures(s1img2, remainingFAST2, 'Method', 'SURF');
indexPairsFAST1 = matchFeatures(surfFeaturesFAST1, surfFeaturesFAST2, 'Method', 'NearestNeighborRatio');
indexPairsFASTR1 = matchFeatures(surfFeaturesFASTR1, surfFeaturesFASTR2, 'Method', 'NearestNeighborRatio');
matchedPointsFAST1 = validPointsFAST1(indexPairsFAST1(:, 1));
matchedPointsFAST2 = validPointsFAST2(indexPairsFAST1(:, 2));
matchedPointsFASTR1 = validPointsFASTR1(indexPairsFASTR1(:, 1));
matchedPointsFASTR2 = validPointsFASTR2(indexPairsFASTR1(:, 2));
figure;
showMatchedFeatures(s1img1, s1img2, matchedPointsFAST1, matchedPointsFAST2, 'montage');
title('Matched SURF Features Between Image 1 and Image 2 for FAST Points');
figure;
showMatchedFeatures(s1img1, s1img2, matchedPointsFASTR1, matchedPointsFASTR2, 'montage');
title('Matched SURF Features Between Image 1 and Image 2 for FASTR Points');
