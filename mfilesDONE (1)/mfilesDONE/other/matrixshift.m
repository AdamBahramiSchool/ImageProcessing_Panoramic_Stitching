function shiftedImage = matrixshift(image, shiftAmount)
    [rows, cols] = size(image);
    shiftedImage = zeros(rows, cols);
    shiftedRows = mod((1:rows) - shiftAmount(1) - 1, rows) + 1;
    shiftedCols = mod((1:cols) - shiftAmount(2) - 1, cols) + 1;
    shiftedImage = image(shiftedRows, shiftedCols);
end
