function [data,info] = addConfettiNoiseForPillAnomalyDetector(data,info)
% The addConfettiNoiseForPillAnomalyDetector function adds synthetic
% confetti noise anomalies to an input image.
%
% Copyright 2021 The MathWorks, Inc.

onehotLabel = 1;
if info.Label ~= categorical("normal") % Do not add confetti noise to real anomaly images.
    dataOut = data;
else
    if rand > 0.5
        dataOut = confettiNoise(data,NumBlobsRange=[1 15]);
    else % no defects added
        dataOut = data;
        onehotLabel = 0;
    end
end

data = {dataOut,onehotLabel};
end