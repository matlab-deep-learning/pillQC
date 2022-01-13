classdef fcddLossLayer < nnet.layer.RegressionLayer

    properties
        % (Optional) Layer properties.

        % Layer properties go here.
    end

    methods
        function layer = fcddLossLayer()
            % (Optional) Create a myRegressionLayer.

            % Layer constructor function goes here.
            layer.Name = 'fcddLoss';
        end

        function loss = forwardLoss(~, Y, T)
            normalTerm = Y;
            anomalyTerm = log(1 - exp(-normalTerm));

            isGood = ~T;
            loss = mean(isGood .* normalTerm -~isGood .* anomalyTerm);
        end

    end
end