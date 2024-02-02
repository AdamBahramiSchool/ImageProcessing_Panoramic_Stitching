function [] = SURFmatching(s1img1,s1img2,candidatecorners1,candidatecorners2,remainingFAST1,remainingFAST2)
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
end