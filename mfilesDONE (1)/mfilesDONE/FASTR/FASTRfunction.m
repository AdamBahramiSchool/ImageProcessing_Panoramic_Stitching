function remainingFAST = FASTRfunction(s1img1,candidatecorners)
    sobKern=[-1 0 1; -2 0 2; -1 0 1];
    gausKern=fspecial("gaussian",10,2);
    dogKern=conv2(gausKern,sobKern);
    ix=imfilter(s1img1,dogKern);
    iy=imfilter(s1img1,dogKern');
    ix2gaussian=imfilter(ix.*ix,gausKern);
    iy2gaussian=imfilter(iy.*iy,gausKern);
    ixiygaussian=imfilter(ix.*iy,gausKern);
    harrisCornerMeasure=ix2gaussian.*iy2gaussian-ixiygaussian-0.05.*(ix2gaussian+iy2gaussian).^2;
    localMax=imdilate(harrisCornerMeasure,ones(3));
    outputCornersHarris=((harrisCornerMeasure==localMax).*(harrisCornerMeasure>0.06));
    
    [row2,col2 ] = find(outputCornersHarris);
    remainingFAST = [];
    radius=10;
    for i=1:numel(row2)
        hcX=col2(i);
        hcY=row2(i);
        distance=sqrt((candidatecorners(:,2)-hcX).^2+(candidatecorners(:,1)-hcY).^2);
        inRangeFAST=candidatecorners(distance<=radius,:);
        remainingFAST=[remainingFAST; inRangeFAST];
    end
    
    figure;
    imshow(s1img1);
    hold on;
    scatter(remainingFAST(:,2), remainingFAST(:,1), 50, 'b', 'filled');
    
    hold off;
end

