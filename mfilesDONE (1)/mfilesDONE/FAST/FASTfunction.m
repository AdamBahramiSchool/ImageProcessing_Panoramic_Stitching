function candidateCorners = FASTfunction(s1img1,fastThreshold)
    gausKern=fspecial("gaussian",20,2);
    s1img1=imfilter(s1img1,gausKern);
    shifted_right = matrixshift(s1img1, [0, 1]);
    shifted_left = matrixshift(s1img1, [0, -1]);
    shifted_up = matrixshift(s1img1, [-1, 0]);
    shifted_down = matrixshift(s1img1, [1, 0]);
    
    shifted_up_right = matrixshift(s1img1, [-1, 1]);
    shifted_up_left = matrixshift(s1img1, [-1, -1]);
    shifted_down_right = matrixshift(s1img1, [1, 1]);
    shifted_down_left = matrixshift(s1img1, [1, -1]);
    
    % Check if a set of N contiguous pixels in the circle are all brighter than Ip + t
    is_brighter_right = s1img1+fastThreshold < shifted_right ;
    is_brighter_left = s1img1+fastThreshold < shifted_left;
    is_brighter_up = s1img1 +fastThreshold < shifted_up ;
    is_brighter_down = s1img1 +fastThreshold< shifted_down ;
    is_brighter_up_right = s1img1+fastThreshold < shifted_up_right ;
    is_brighter_up_left = s1img1 +fastThreshold< shifted_up_left ;
    is_brighter_down_right = s1img1+fastThreshold < shifted_down_right ;
    is_brighter_down_left = s1img1 +fastThreshold< shifted_down_left ;
    
    % Boolean check, if boolean conditions have contigous pixels results in true, its a corner
    highspeedCornerTest = is_brighter_right & is_brighter_left & is_brighter_up & is_brighter_down & is_brighter_up_right & is_brighter_up_left & is_brighter_down_right & is_brighter_down_left;
    
    % Looks for boolean true values
    [row, col] = find(highspeedCornerTest);
    
    % List the candidate pixels as corners
    candidateCorners = [row col];
    
    figure;
    imshow(s1img1);
    hold on;
    scatter(col, row, 'r', 'filled');
    hold off;
end

