function [B,mask] = confettiNoise(A,NameValueArgs)
% confettiNoise Adds confettiNoise to input image
%   B = confettiNoise(A) adds confetti noise to input image A.
%
%   B = confettiNoise(A,Name,Value,___) adds confetti noise with Name-Value
%   pairs used to control aspects of augmentation. 
%
%   Parameters include:
%
%   'NumBlobsRange'         - Two element integer valued vector which
%                             describes the minimum and maximum number of
%                             colored patches which will be added to the input image.
%                             The actual number is uniformly selected from
%                             this range.
%
%   'WidthRange'            - Two element vector which describes the min
%                             and max width of each rectangular patch.
%
%   'HeightRange'           - Two element vector which describes the min
%                             and max height of each rectanglar patch.
%
%   'NoiseBlendRatio'       - Scalar which describes how much weight each
%                             colored patch has when it is blended with the
%                             underlying image data. Values must be in the
%                             range [0,1] where higher values mean that
%                             colored patches will be more opaque.
%                          
%   [B,mask] = confettiNoise(___) additionally provides a binary mask which
%   describes the locations where noise patches were added to A.
%
%   Example 1
%   ---------
%
%   A = imread('peppers.png');
%   [B,BW] = confettiNoise(A,NumBlobsRange=[10 20]);
%
%   figure
%   montage({B,BW});

%   Copyright 2021, The MathWorks, Inc.

arguments
    A
    NameValueArgs.NumBlobsRange = [1 4];
    NameValueArgs.WidthRange = [5 20];
    NameValueArgs.HeightRange = [5 20];
    NameValueArgs.NoiseBlendRatio = 0.4;
end

As = im2double(A);

numBlobs = NameValueArgs.NumBlobsRange(1)+randi(diff(NameValueArgs.NumBlobsRange)+1)-1;

% Make sure each rectangle will completely fit inside image bounds even
% when rotated.
maxSideLength = ceil(sqrt(2) * max(NameValueArgs.WidthRange(2),NameValueArgs.HeightRange(2)));

minX = randi(size(A,2)-maxSideLength+1,1,numBlobs);
minY = randi(size(A,1)-maxSideLength+1,1,numBlobs);

maxX = minX + NameValueArgs.WidthRange(1) + randi(diff(NameValueArgs.WidthRange)+1,1,numBlobs)-1;
maxY = minY + NameValueArgs.HeightRange(1) + randi(diff(NameValueArgs.HeightRange)+1,1,numBlobs)-1;

% For each blob, create a corresponding mask
mask = false([size(A,[1 2])]);
for b = 1:numBlobs
    angle = 360*rand;
    rect = images.roi.Rectangle("Position",[minX(b), minY(b), maxX(b)-minX(b),maxY(b)-minY(b)],...
        'Rotatable',true,"RotationAngle",angle);

    mask = mask | createMask(rect,size(mask,1),size(mask,2));
end

% Form colors for each blob
c = rand(numBlobs,size(A,3));

% Form labelmatrix representation of mask
L = bwlabel(mask);

B = zeros(size(As),'like',As);
BW = repmat(L==0,[1 1 size(A,3)]);
B(BW) = As(BW);
alpha = NameValueArgs.NoiseBlendRatio;
for b = 1:numBlobs
    colorToBlend = repmat(reshape(c(b,:),[1 1 size(c,2)]),[size(A,[1 2]),1]);
    BW = repmat(L==b,[1 1 size(A,3)]);
    B(BW) = (1-alpha) .* As(BW) + alpha .* colorToBlend(BW);
end

B = im2uint8(B);
