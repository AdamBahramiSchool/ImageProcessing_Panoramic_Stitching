function [] = panoramaCreator(s1img1,s1img2,s1p,confidenceLevel,maxTrials,FASTRs11,FASTRs12)
    %s1img1 = im2double(imread("..\imageSet\S4-im1.png"));
    %s1img2 = im2double(imread("..\imageSet\S4-im2.png"));
    
    % Extract SURF features and descriptors for FASTR points in the first image set
    [features1, validPointsFASTR1] = extractFeatures(s1img1, FASTRs11, 'Method', 'SURF');
    
    % Extract SURF features and descriptors for FASTR points in the second image set
    [features2, validPointsFASTR2] = extractFeatures(s1img2, FASTRs12, 'Method', 'SURF');
    
    % Match features between the two images
    indexPairs = matchFeatures(features1, features2);
    matchedPoints1 = validPointsFASTR1(indexPairs(:, 1));
    matchedPoints2 = validPointsFASTR2(indexPairs(:, 2));
    
    n=2;
    tforms(2)=projective2d(eye(3));
    ImageSize=zeros(n, 2);

   minRequiredPoints = 20;
    maxIterations = 5;  % Set a maximum number of iterations
    
    iteration = 0;
    newPointsAdded = true;

    while numel(matchedPoints1) < minRequiredPoints && newPointsAdded && iteration < maxIterations
        % Detect additional SURF features in the first image
        additionalSurfPoints1 = detectSURFFeatures(s1img1);
        
        % Detect additional SURF features in the second image
        additionalSurfPoints2 = detectSURFFeatures(s1img2);
        
        % Extract additional SURF features and descriptors
        [additionalFeatures1, additionalPoints1] = extractFeatures(s1img1, additionalSurfPoints1, 'Method', 'SURF');
        [additionalFeatures2, additionalPoints2] = extractFeatures(s1img2, additionalSurfPoints2, 'Method', 'SURF');
        
        % Match the additional features
        additionalIndexPairs = matchFeatures(additionalFeatures1, additionalFeatures2);
        
        % Check if any new points were added
        newPointsAdded = ~isempty(additionalIndexPairs);
        
        if newPointsAdded
            % Add the matching points to the existing sets
            matchedPoints1 = [matchedPoints1; additionalSurfPoints1(additionalIndexPairs(:, 1))];
            matchedPoints2 = [matchedPoints2; additionalSurfPoints2(additionalIndexPairs(:, 2))];
        end
        
        iteration = iteration + 1;
    end

    
    tforms(n) = estimateGeometricTransform(matchedPoints2, matchedPoints1, 'projective', 'Confidence', confidenceLevel, 'MaxNumTrials', maxTrials);
    tforms(n).T=tforms(n).T * tforms(n-1). T;
    ImageSize(2,:)=size(s1img2);
    for i = 1:numel(tforms)
            [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 ImageSize(i,2)], [1 ImageSize(i,1)]);
    end
    avgXLim = mean(xlim, 2);
    
    [~, idx] = sort(avgXLim);
    
    centerIdx = floor((numel(tforms)+1)/2);
    
    centerImageIdx = idx(centerIdx);
    Tinv = invert(tforms(centerImageIdx));
    
    for i = 1:numel(tforms)
        tforms(i).T = tforms(i).T * Tinv.T;
    end
    for i = 1:numel(tforms)           
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 ImageSize(i,2)], [1 ImageSize(i,1)]);
    end
    
    maxImageSize = max(ImageSize);
    xMin = min([1; xlim(:)]);
    xMax = max([maxImageSize(2); xlim(:)]);
    
    yMin = min([1; ylim(:)]);
    yMax = max([maxImageSize(1); ylim(:)]);
    
    width  = round(xMax - xMin);
    height = round(yMax - yMin);
    
    % Initialize the "empty" panorama.
    panorama = zeros([height width], 'like', s1img2);
    blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  
    
    % Create a 2-D spatial reference object defining the size of the panorama.
    xLimits = [xMin xMax];
    yLimits = [yMin yMax];
    panoramaView = imref2d([height width], xLimits, yLimits);
    
    i=1;
    I = s1img1;
    
    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(1), 'OutputView', panoramaView);
    
    % Generate a binary mask.
    mask = imwarp(true(size(I,1),size(I,2)), tforms(1), 'OutputView', panoramaView);
    panorama = step(blender, panorama, warpedImage, mask);
    %%
    i=2;
    I = s1img2;
    
    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(2), 'OutputView', panoramaView);
    
    % Generate a binary mask.
    mask = imwarp(true(size(I,1),size(I,2)), tforms(2), 'OutputView', panoramaView);
    panorama = step(blender, panorama, warpedImage, mask);
    %%
    figure;
    imshow(s1p);
    title('Panorama')



end