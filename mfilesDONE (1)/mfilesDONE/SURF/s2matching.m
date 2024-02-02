s2img1=im2double(imread("..\imageSet\S2-im1.png"));
shifted_right2 = matrixshift(s2img1, [0, 1]);
shifted_left2= matrixshift(s2img1, [0, -1]);
shifted_up2 = matrixshift(s2img1, [-1, 0]);
shifted_down2 = matrixshift(s2img1, [1, 0]);

shifted_up_right2 = matrixshift(s2img1, [-1, 1]);
shifted_up_left2 = matrixshift(s2img1, [-1, -1]);
shifted_down_right2 = matrixshift(s2img1, [1, 1]);
shifted_down_left2 = matrixshift(s2img1, [1, -1]);
fastThreshold2= 0.03999;

% Check if a set of N contiguous pixels in the circle are all brighter than Ip + t
is_brighter_right2 = s2img1+fastThreshold2 < shifted_right2 ;
is_brighter_left2 = s2img1+fastThreshold2 < shifted_left2;
is_brighter_up2 = s2img1 +fastThreshold2 < shifted_up2 ;
is_brighter_down2 = s2img1 +fastThreshold2< shifted_down2 ;
is_brighter_up_right2 = s2img1+fastThreshold2 < shifted_up_right2 ;
is_brighter_up_left2 = s2img1 +fastThreshold2< shifted_up_left2 ;
is_brighter_down_right2 = s2img1+fastThreshold2 < shifted_down_right2 ;
is_brighter_down_left2 = s2img1 +fastThreshold2< shifted_down_left2 ;

% Boolean check, if boolean conditions have contigous pixels results in true, its a corner
highspeedCornerTest2 = is_brighter_right2 & is_brighter_left2 & is_brighter_up2 & is_brighter_down2 & is_brighter_up_right2 & is_brighter_up_left2 & is_brighter_down_right2 & is_brighter_down_left2;
[row2, col2] = find(highspeedCornerTest2);

% List the candidate pixels as corners
candidatecorners2 = [row2 col2];

sobKern2 = [-1 0 1; -2 0 2; -1 0 1];
gausKern2 = fspecial("gaussian", 10, 1);
dogKern2 = conv2(gausKern2, sobKern2);
ix2 = imfilter(s2img1, dogKern2);
iy2 = imfilter(s2img1, dogKern2');
ix2gaussian2 = imfilter(ix2 .* ix2, gausKern2);
iy2gaussian2 = imfilter(iy2 .* iy2, gausKern2);
ixiygaussian2 = imfilter(ix2 .* iy2, gausKern2);
harrisCornerMeasure2 = ix2gaussian2 .* iy2gaussian2 - ixiygaussian2 - 0.05 .* (ix2gaussian2 + iy2gaussian2).^2;
localMax2 = imdilate(harrisCornerMeasure2, ones(7));
outputCornersHarris2 = ((harrisCornerMeasure2 == localMax2) .* (harrisCornerMeasure2 > 0.06));

[row3, col3] = find(outputCornersHarris2);
remainingFAST2 = [];
radius2=20;
for i=1:numel(row3)
    hcX=col3(i);
    hcY=row3(i);
    distance=sqrt((candidatecorners2(:,2)-hcX).^2+(candidatecorners2(:,1)-hcY).^2);
    inRangeFAST=candidatecorners2(distance<=radius2,:);
    remainingFAST2=[remainingFAST2; inRangeFAST];
end

s2img2 = im2double(imread("..\imageSet\S2-im2.png"));
%gausKern = fspecial("gaussian", 20, 2);
%s2img2 = imfilter(s2img2, gausKern);
shifted_right2 = matrixshift(s2img2, [0, 1]);
shifted_left2 = matrixshift(s2img2, [0, -1]);
shifted_up2 = matrixshift(s2img2, [-1, 0]);
shifted_down2 = matrixshift(s2img2, [1, 0]);

shifted_up_right2 = matrixshift(s2img2, [-1, 1]);
shifted_up_left2 = matrixshift(s2img2, [-1, -1]);
shifted_down_right2 = matrixshift(s2img2, [1, 1]);
shifted_down_left2 = matrixshift(s2img2, [1, -1]);
fastThreshold2 = 0.03999;
is_brighter_right2 = s2img2 + fastThreshold2 < shifted_right2;
is_brighter_left2 = s2img2 + fastThreshold2 < shifted_left2;
is_brighter_up2 = s2img2 + fastThreshold2 < shifted_up2;
is_brighter_down2 = s2img2 + fastThreshold2 < shifted_down2;
is_brighter_up_right2 = s2img2 + fastThreshold2 < shifted_up_right2;
is_brighter_up_left2 = s2img2 + fastThreshold2 < shifted_up_left2;
is_brighter_down_right2 = s2img2 + fastThreshold2 < shifted_down_right2;
is_brighter_down_left2 = s2img2 + fastThreshold2 < shifted_down_left2;
highspeedCornerTest2 = is_brighter_right2 & is_brighter_left2 & is_brighter_up2 & is_brighter_down2 & is_brighter_up_right2 & is_brighter_up_left2 & is_brighter_down_right2 & is_brighter_down_left2;
[row3, col3] = find(highspeedCornerTest2);
candidatecorners3 = [row3 col3];
sobKern3 = [-1 0 1; -2 0 2; -1 0 1];
gausKern3 = fspecial("gaussian", 10, 1);
dogKern3 = conv2(gausKern3, sobKern3);
ix3 = imfilter(s2img2, dogKern3);
iy3 = imfilter(s2img2, dogKern3');
ix2gaussian3 = imfilter(ix3 .* ix3, gausKern3);
iy2gaussian3 = imfilter(iy3 .* iy3, gausKern3);
ixiygaussian3 = imfilter(ix3 .* iy3, gausKern3);
harrisCornerMeasure3 = ix2gaussian3 .* iy2gaussian3 - ixiygaussian3 - 0.05 .* (ix2gaussian3 + iy2gaussian3).^2;
localMax3 = imdilate(harrisCornerMeasure3, ones(7));
outputCornersHarris3 = ((harrisCornerMeasure3 == localMax3) .* (harrisCornerMeasure3 > 0.06));

[row4, col4] = find(outputCornersHarris3);

remainingFAST3 = [];
radius3=70;
for i=1:numel(row4)
    hcX=col4(i);
    hcY=row4(i);
    distance=sqrt((candidatecorners2(:,2)-hcX).^2+(candidatecorners2(:,1)-hcY).^2);
    inRangeFAST=candidatecorners2(distance<=radius2,:);
    remainingFAST3=[remainingFAST3; inRangeFAST];
end

points11 = detectSURFFeatures(s2img1);
points22 = detectSURFFeatures(s2img2);
[features11, validPoints11] = extractFeatures(s2img1, points11);
[features22, validPoints22] = extractFeatures(s2img2, points22);
indexPairs = matchFeatures(features11, features22, 'Method', 'NearestNeighborRatio');
matchedPoints11 = validPoints11(indexPairs(:, 1));
matchedPoints22 = validPoints22(indexPairs(:, 2));
compositeImageSwitched = cat(2, s2img2, s2img1); 
matchedPoints22.Location(:, 1) = matchedPoints22.Location(:, 1) + size(s2img1, 2);

[surfFeaturesFAST1, validPointsFAST1] = extractFeatures(s2img1, candidatecorners2, 'Method', 'SURF');
[surfFeaturesFASTR1, validPointsFASTR1] = extractFeatures(s2img1, remainingFAST2, 'Method', 'SURF');
[surfFeaturesFAST2, validPointsFAST2] = extractFeatures(s2img2, candidatecorners3, 'Method', 'SURF');
[surfFeaturesFASTR2, validPointsFASTR2] = extractFeatures(s2img2, remainingFAST3, 'Method', 'SURF');
indexPairsFAST1 = matchFeatures(surfFeaturesFAST1, surfFeaturesFAST2, 'Method', 'NearestNeighborRatio');
indexPairsFASTR1 = matchFeatures(surfFeaturesFASTR1, surfFeaturesFASTR2, 'Method', 'NearestNeighborRatio');
matchedPointsFAST1 = validPointsFAST1(indexPairsFAST1(:, 1));
matchedPointsFAST2 = validPointsFAST2(indexPairsFAST1(:, 2));
matchedPointsFASTR1 = validPointsFASTR1(indexPairsFASTR1(:, 1));
matchedPointsFASTR2 = validPointsFASTR2(indexPairsFASTR1(:, 2));
figure;
showMatchedFeatures(s2img1, s2img2, matchedPointsFAST1, matchedPointsFAST2, 'montage');
title('Matched SURF Features Between s2img1 and s2img2 for FAST Points');

figure;
imshow(compositeImageSwitched);
hold on;
plot(matchedPoints11);
plot(matchedPoints22);
for i = 1:size(matchedPoints11, 1)
    x1 = matchedPoints11.Location(i, 1);
    y1 = matchedPoints11.Location(i, 2);
    x2 = matchedPoints22.Location(i, 1);
    y2 = matchedPoints22.Location(i, 2);
    line([x1, x2], [y1, y2], 'Color', 'r', 'LineWidth', 1);
end
title('Matched SURF Features Between s2img1 and s2img2 for FASTR Points');








